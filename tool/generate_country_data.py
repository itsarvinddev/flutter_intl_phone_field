#!/usr/bin/env python3
"""Regenerate the country data bundled with flutter_intl_phone_field.

Sources
-------
* Calling codes, national-number lengths, area codes, example numbers,
  validation patterns and national formatting rules come from Google's
  libphonenumber metadata (PhoneNumberMetadata.xml, Apache-2.0).
* Localised country names come from the Unicode CLDR (cldr-json).

Outputs (all marked GENERATED; never hand-edit them)
----------------------------------------------------
    lib/src/countries.dart          const List<Country> countries
    lib/src/country_patterns.dart   ISO code -> national number regex
    lib/src/number_formats.dart     ISO code -> national formatting rules
    test/libphonenumber_examples.dart
                                    every published example number and the ISO
                                    code the resolver must return for it

Usage
-----
    python3 tool/generate_country_data.py            # fetch sources and write
    python3 tool/generate_country_data.py --offline  # reuse tool/.cache

Requires Python 3.10+ and network access on the first run.
"""

from __future__ import annotations

import argparse
import collections
import io
import json
import os
import re
import sys
import urllib.request
import xml.etree.ElementTree as ET

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CACHE = os.path.join(ROOT, "tool", ".cache")

METADATA_URL = (
    "https://raw.githubusercontent.com/google/libphonenumber/master/"
    "resources/PhoneNumberMetadata.xml"
)
CLDR_URL = (
    "https://raw.githubusercontent.com/unicode-org/cldr-json/main/cldr-json/"
    "cldr-localenames-full/main/{locale}/territories.json"
)

# Translation keys the package exposes, mapped to their CLDR locale.
LOCALES = {
    "sk": "sk", "se": "se", "pl": "pl", "no": "nb", "ja": "ja", "it": "it",
    "zh": "zh", "nl": "nl", "de": "de", "fr": "fr", "es": "es", "en": "en",
    "pt_BR": "pt", "sr-Cyrl": "sr-Cyrl", "sr-Latn": "sr-Latn",
    "zh_TW": "zh-Hant", "tr": "tr", "ro": "ro", "ru": "ru", "ar": "ar",
    "fa": "fa", "yue": "yue",
}
TKEYS = list(LOCALES)

# Number types a person might enter as their own number.
CORE_TYPES = ("mobile", "fixedLine")
ALL_TYPES = CORE_TYPES + (
    "pager", "tollFree", "premiumRate", "sharedCost", "personalNumber",
    "voip", "uan", "voicemail",
)

# Territories with no assigned numbering of their own. They stay selectable but
# must never win an automatic lookup, or they would shadow their neighbours
# (Bouvet Island shares +47 with Norway, Antarctica +672 with Norfolk Island).
NO_NUMBERING = {"AQ", "BV", "TF", "HM", "PN", "GS"}


def fetch(url: str, name: str, offline: bool) -> bytes:
    os.makedirs(CACHE, exist_ok=True)
    path = os.path.join(CACHE, name)
    if os.path.exists(path):
        return open(path, "rb").read()
    if offline:
        sys.exit(f"--offline given but {path} is missing")
    print(f"  fetching {name}", file=sys.stderr)
    data = urllib.request.urlopen(url).read()
    open(path, "wb").write(data)
    return data


def parse_lengths(spec: str) -> set[int]:
    """libphonenumber possibleLengths syntax: "7", "7,9", "9-10", "[4-7]"."""
    out: set[int] = set()
    for part in re.findall(r"\[\d-\d\]|\d+-\d+|\d+", spec.strip()):
        if part.startswith("["):
            out.update(range(int(part[1]), int(part[3]) + 1))
        elif "-" in part:
            lo, hi = part.split("-")
            out.update(range(int(lo), int(hi) + 1))
        else:
            out.add(int(part))
    return out


def load_metadata(offline: bool) -> dict:
    raw = fetch(METADATA_URL, "PhoneNumberMetadata.xml", offline)
    root = ET.fromstring(raw)
    data: dict[str, dict] = {}
    for t in root.findall(".//territory"):
        tid = t.get("id") or ""
        if len(tid) != 2 or not tid.isalpha():
            continue  # skip non-geographic entities such as 800 and 979
        core: set[int] = set()
        every: set[int] = set()
        examples: dict[str, str] = {}
        geo_patterns: list[str] = []
        for ty in ALL_TYPES:
            el = t.find(ty)
            if el is None:
                continue
            lengths = el.find("possibleLengths")
            if lengths is not None and lengths.get("national"):
                parsed = parse_lengths(lengths.get("national"))
                every |= parsed
                if ty in CORE_TYPES:
                    core |= parsed
            ex = el.find("exampleNumber")
            if ex is not None and ex.text:
                examples[ty] = ex.text.strip()
            if ty in CORE_TYPES:
                pat = el.find("nationalNumberPattern")
                if pat is not None and pat.text:
                    geo_patterns.append(re.sub(r"\s+", "", pat.text))

        formats = []
        available = t.find("availableFormats")
        if available is not None:
            for nf in available.findall("numberFormat"):
                fmt = nf.find("format")
                if nf.get("pattern") is None or fmt is None or not fmt.text:
                    continue
                leading = [
                    re.sub(r"\s+", "", ld.text or "")
                    for ld in nf.findall("leadingDigits")
                ]
                formats.append({
                    "pattern": re.sub(r"\s+", "", nf.get("pattern")),
                    "format": fmt.text.strip(),
                    # The last leadingDigits element is the most specific.
                    "leadingDigits": leading[-1] if leading else None,
                    "nationalPrefixFormattingRule":
                        nf.get("nationalPrefixFormattingRule"),
                })

        data[tid] = {
            "countryCode": t.get("countryCode"),
            "main": t.get("mainCountryForCode") == "true",
            "nationalPrefix": t.get("nationalPrefix"),
            "coreLengths": sorted(core or every),
            "examples": examples,
            "geoPattern": "|".join(f"(?:{p})" for p in geo_patterns) or None,
            "formats": formats,
        }
    return data


def load_cldr(offline: bool) -> dict:
    out = {}
    for key, locale in LOCALES.items():
        raw = fetch(CLDR_URL.format(locale=locale), f"cldr-{locale}.json", offline)
        doc = json.loads(raw)["main"]
        name = next(iter(doc))
        out[key] = doc[name]["localeDisplayNames"]["territories"]
    return out


def derive_area_codes(meta: dict) -> dict[str, list[str]]:
    """Three-digit area codes per +1 territory, probed against its own ranges."""
    generic = {
        "2345678", "5550123", "1234567", "4641234", "3001234", "7001234",
        "2251234", "9876543", "5551234", "4921234",
    }
    out = {}
    for tid, m in meta.items():
        if m["countryCode"] != "1" or not m["geoPattern"]:
            continue
        rx = re.compile("^(?:" + m["geoPattern"] + ")$")
        probes = generic | {
            ex[3:] for ex in m["examples"].values() if len(ex) == 10
        }
        out[tid] = [
            str(a) for a in range(200, 1000)
            if any(rx.match(f"{a}{p}") for p in probes)
        ]
    return out


def derive_leading_digits(meta: dict) -> dict[str, list[str]]:
    """Shortest national-number prefixes unique to a territory among those
    sharing its calling code. This is what lets +447781... be recognised as
    Guernsey while +447400... stays British."""
    shared = collections.defaultdict(list)
    for tid, m in meta.items():
        if m["geoPattern"]:
            shared[m["countryCode"]].append(tid)
    shared = {cc: ids for cc, ids in shared.items() if len(ids) > 1}

    rx = {
        tid: re.compile("^(?:" + m["geoPattern"] + ")$")
        for tid, m in meta.items() if m["geoPattern"]
    }

    def accepts(tid: str, prefix: str) -> bool:
        tails = {ex[len(prefix):] for ex in meta[tid]["examples"].values()
                 if len(ex) >= len(prefix)}
        probes = {""} | tails | {
            d * n for d in "0123456789" for n in range(1, 12)
        } | {
            "2345678", "5550123", "1234567", "0123456", "1234", "12345",
            "123456", "12345678", "123456789",
        }
        return any(rx[tid].match(prefix + p) for p in probes)

    out: dict[str, list[str]] = {}
    for cc, ids in shared.items():
        for tid in ids:
            if meta[tid]["main"]:
                continue  # the main country is the fallback, it needs no prefix
            found: list[str] = []
            for n in range(1, 5):
                for value in range(10 ** (n - 1), 10 ** n):
                    prefix = str(value).zfill(n)
                    if any(prefix.startswith(f) for f in found):
                        continue
                    if accepts(tid, prefix) and not any(
                        accepts(other, prefix) for other in ids if other != tid
                    ):
                        found.append(prefix)
            out[tid] = sorted(found)
    return out


def dq(value: str | None) -> str:
    """Dart double-quoted string literal."""
    if value is None:
        return "null"
    escaped = (value.replace("\\", r"\\").replace('"', r"\"")
                    .replace("$", r"\$").replace("\n", r"\n"))
    return f'"{escaped}"'


def rq(value: str) -> str:
    """Dart raw string. Raw strings take no escapes, so the value must contain
    neither a double quote nor a dollar sign."""
    assert '"' not in value and "$" not in value, value[:80]
    return f'r"{value}"'


HEADER = """// GENERATED FILE -- DO NOT EDIT BY HAND.
//
// Regenerate with `python3 tool/generate_country_data.py`; see tool/README.md.
//
// {what}
//
// Derived from Google's libphonenumber metadata (Apache-2.0){cldr}.
"""


def build(meta: dict, cldr: dict) -> dict:
    area_codes = derive_area_codes(meta)
    leading = derive_leading_digits(meta)

    countries: dict[str, dict] = {}
    for tid, m in meta.items():
        codes = area_codes.get(tid, [])
        # One area code is a fixed prefix the user never types; several (the US,
        # Canada, Puerto Rico, the Dominican Republic, Jamaica) are part of the
        # national number, so the field must accept all ten digits.
        region = codes[0] if len(codes) == 1 else ""
        lo, hi = min(m["coreLengths"]), max(m["coreLengths"])
        example = m["examples"].get("mobile") or m["examples"].get("fixedLine")
        countries[tid] = {
            "code": tid,
            "name": cldr["en"].get(tid, tid),
            "nameTranslations": {
                k: cldr[k][tid] for k in TKEYS if cldr[k].get(tid)
            },
            "flag": "".join(
                chr(0x1F1E6 + ord(ch) - ord("A")) for ch in tid
            ),
            "dialCode": m["countryCode"],
            "regionCode": region,
            "minLength": lo - len(region),
            "maxLength": hi - len(region),
            "example": example[len(region):] if example else None,
            "nationalPrefix": m["nationalPrefix"],
            "main": m["main"],
            "leadingDigits": leading.get(tid, []),
            "areaCodes": codes if len(codes) > 1 else [],
            "autoDetectable": True,
            "geoPattern": m["geoPattern"],
            "formats": m["formats"],
        }

    # Territories with no numbering of their own: selectable, never auto-matched.
    for tid in NO_NUMBERING:
        if tid in countries:
            continue
        countries[tid] = {
            "code": tid,
            "name": cldr["en"].get(tid, tid),
            "nameTranslations": {
                k: cldr[k][tid] for k in TKEYS if cldr[k].get(tid)
            },
            "flag": "".join(chr(0x1F1E6 + ord(ch) - ord("A")) for ch in tid),
            "dialCode": {"AQ": "672", "BV": "47", "TF": "262", "HM": "672",
                         "PN": "64", "GS": "500"}[tid],
            "regionCode": "", "minLength": 1, "maxLength": 15,
            "example": None, "nationalPrefix": None, "main": False,
            "leadingDigits": [], "areaCodes": [], "autoDetectable": False,
            "geoPattern": None, "formats": [],
        }

    # A calling code used by exactly one real territory has that territory as
    # its main country; libphonenumber only marks mainCountryForCode when a
    # code is shared.
    live = collections.defaultdict(list)
    for tid, c in countries.items():
        if c["autoDetectable"]:
            live[c["dialCode"]].append(tid)
    for cc, ids in live.items():
        if not any(countries[i]["main"] for i in ids):
            countries[ids[0]]["main"] = True

    # Placeholder territories borrow the length range of their calling code's
    # main country so the field behaves sanely if one is selected by hand.
    for tid, c in countries.items():
        if c["autoDetectable"]:
            continue
        peer = next(
            (countries[i] for i in live.get(c["dialCode"], [])
             if countries[i]["main"]),
            None,
        )
        if peer:
            c["minLength"], c["maxLength"] = peer["minLength"], peer["maxLength"]

    # E.164 caps a complete number at 15 digits.
    for c in countries.values():
        cap = 15 - len(c["dialCode"]) - len(c["regionCode"])
        c["maxLength"] = max(1, min(c["maxLength"], cap))
        c["minLength"] = max(1, min(c["minLength"], c["maxLength"]))

    return countries


def write_countries(countries: dict, order: list[str]) -> str:
    o = io.StringIO()
    o.write(HEADER.format(
        what="Every country and territory the package knows, sorted by English\n"
             "// name. Lengths exclude the dial code and any fixed area code.",
        cldr=", with localised names from the Unicode CLDR",
    ))
    o.write("\nimport 'country.dart';\n\n")
    o.write("/// Every country and territory known to the package, sorted by "
            "English name.\nconst List<Country> countries = <Country>[\n")
    for tid in order:
        c = countries[tid]
        o.write("  Country(\n")
        o.write(f"    name: {dq(c['name'])},\n")
        o.write("    nameTranslations: {\n")
        for k in TKEYS:
            if c["nameTranslations"].get(k):
                o.write(f"      {dq(k)}: {dq(c['nameTranslations'][k])},\n")
        o.write("    },\n")
        o.write(f"    flag: {dq(c['flag'])},\n")
        o.write(f"    code: {dq(c['code'])},\n")
        o.write(f"    dialCode: {dq(c['dialCode'])},\n")
        if c["regionCode"]:
            o.write(f"    regionCode: {dq(c['regionCode'])},\n")
        o.write(f"    minLength: {c['minLength']},\n")
        o.write(f"    maxLength: {c['maxLength']},\n")
        if c["example"]:
            o.write(f"    example: {dq(c['example'])},\n")
        if c["nationalPrefix"]:
            o.write(f"    nationalPrefix: {dq(c['nationalPrefix'])},\n")
        if c["main"]:
            o.write("    isMainCountryForDialCode: true,\n")
        if not c["autoDetectable"]:
            o.write("    autoDetectable: false,\n")
        if c["leadingDigits"]:
            joined = ", ".join(dq(p) for p in c["leadingDigits"])
            o.write(f"    leadingDigits: [{joined}],\n")
        if c["areaCodes"]:
            joined = ", ".join(dq(p) for p in c["areaCodes"])
            o.write(f"    areaCodes: [{joined}],\n")
        o.write("  ),\n")
    o.write("];\n")
    return o.getvalue()


def write_patterns(countries: dict, order: list[str]) -> str:
    o = io.StringIO()
    o.write(HEADER.format(
        what="Per-territory fixed-line and mobile number patterns, used for\n"
             "// strict validation.",
        cldr="",
    ))
    o.write("\n/// Maps an ISO 3166-1 alpha-2 code to a regular expression "
            "matching a valid\n/// national significant number (fixed line or "
            "mobile) for that territory.\n"
            "const Map<String, String> countryNumberPatterns = "
            "<String, String>{\n")
    for tid in order:
        pattern = countries[tid]["geoPattern"]
        if pattern:
            o.write(f"  {dq(tid)}: {rq(pattern)},\n")
    o.write("};\n")
    return o.getvalue()


def write_formats(countries: dict, order: list[str]) -> str:
    o = io.StringIO()
    o.write(HEADER.format(
        what="National number formatting rules, driving as-you-type formatting.",
        cldr="",
    ))
    o.write("\nimport 'phone_number_format.dart';\n\n")
    o.write("/// Maps an ISO 3166-1 alpha-2 code to its ordered national "
            "formatting rules.\n"
            "const Map<String, List<PhoneNumberFormat>> countryNumberFormats =\n"
            "    <String, List<PhoneNumberFormat>>{\n")
    for tid in order:
        rules = countries[tid]["formats"]
        if not rules:
            continue
        o.write(f"  {dq(tid)}: [\n")
        for r in rules:
            o.write("    PhoneNumberFormat(")
            o.write(f"pattern: {rq(r['pattern'])}, format: {dq(r['format'])}")
            if r["leadingDigits"]:
                o.write(f", leadingDigits: {rq(r['leadingDigits'])}")
            if r["nationalPrefixFormattingRule"]:
                o.write(", nationalPrefixFormattingRule: "
                        f"{dq(r['nationalPrefixFormattingRule'])}")
            o.write("),\n")
        o.write("  ],\n")
    o.write("};\n")
    return o.getvalue()


def write_fixture(meta: dict, countries: dict) -> str:
    """Every published example number and the ISO code the resolver must return.

    Where a territory shares both a calling code and its number ranges with a
    neighbour, the example is attributed to the main country for that calling
    code -- which is what libphonenumber does too.
    """
    live = collections.defaultdict(list)
    for tid, c in countries.items():
        if c["autoDetectable"]:
            live[c["dialCode"]].append(tid)
    main = {
        cc: next((i for i in ids if countries[i]["main"]), ids[0])
        for cc, ids in live.items()
    }

    rows, fallbacks = [], 0
    for tid, m in meta.items():
        if tid not in countries:
            continue
        cc = m["countryCode"]
        for ty in CORE_TYPES:
            ex = m["examples"].get(ty)
            if not ex:
                continue
            expect, note = tid, ""
            if len(live[cc]) > 1 and tid != main[cc]:
                if not any(ex.startswith(p)
                           for p in countries[tid]["leadingDigits"]):
                    expect = main[cc]
                    note = (f"  // {tid}: shares its ranges with the +{cc} "
                            "main country")
                    fallbacks += 1
            rows.append((f"+{cc}{ex}", expect, note))

    o = io.StringIO()
    o.write("""// GENERATED FIXTURE -- DO NOT EDIT BY HAND.
//
// Regenerate with `python3 tool/generate_country_data.py`.
//
// Every fixed-line and mobile example number published by Google's
// libphonenumber, paired with the ISO code the resolver must return.
//
// A few territories share both a calling code and their number ranges with a
// neighbour (Vatican City with Italy, the Cocos Islands with Australia). Those
// numbers are attributed to the main country for the calling code, as
// libphonenumber does; each is marked below.

/// `(e164, expectedIsoCode)` pairs covering every territory.
const List<(String, String)> libphonenumberExamples = <(String, String)>[
""")
    for e164, iso, note in sorted(rows):
        o.write(f"  ('{e164}', '{iso}'),{note}\n")
    o.write("];\n")
    print(f"  fixture: {len(rows)} examples, {fallbacks} main-country "
          "fallbacks", file=sys.stderr)
    return o.getvalue()


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--offline", action="store_true",
                    help="reuse tool/.cache instead of fetching")
    args = ap.parse_args()

    print("reading sources", file=sys.stderr)
    meta = load_metadata(args.offline)
    cldr = load_cldr(args.offline)
    print(f"  {len(meta)} territories, {len(cldr)} locales", file=sys.stderr)

    countries = build(meta, cldr)
    order = sorted(countries, key=lambda t: countries[t]["name"])

    outputs = {
        "lib/src/countries.dart": write_countries(countries, order),
        "lib/src/country_patterns.dart": write_patterns(countries, order),
        "lib/src/number_formats.dart": write_formats(countries, order),
        "test/libphonenumber_examples.dart": write_fixture(meta, countries),
    }
    for rel, content in outputs.items():
        path = os.path.join(ROOT, rel)
        open(path, "w", encoding="utf-8").write(content)
        print(f"  wrote {rel} ({len(content) / 1024:.1f} KB)", file=sys.stderr)

    print(f"\n{len(countries)} countries written. Now run:\n"
          "  dart format lib/src test\n"
          "  flutter test test/country_data_test.dart", file=sys.stderr)


if __name__ == "__main__":
    main()
