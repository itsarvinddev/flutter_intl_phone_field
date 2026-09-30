// GENERATED FILE -- DO NOT EDIT BY HAND.
//
// Regenerate with `python3 tool/generate_country_data.py`; see tool/README.md.
//
// National number formatting rules, driving as-you-type formatting.
//
// Derived from Google's libphonenumber metadata (Apache-2.0).

import 'phone_number_format.dart';

/// Maps an ISO 3166-1 alpha-2 code to its ordered national formatting rules.
const Map<String, List<PhoneNumberFormat>>
countryNumberFormats = <String, List<PhoneNumberFormat>>{
  "AF": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[1-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AL": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"80|9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"4[2-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2358][2-5]|4",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[23578]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "DZ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[1-4]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[5-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AD": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"[135-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6",
    ),
  ],
  "AO": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[29]",
    ),
  ],
  "AR": [
    PhoneNumberFormat(
      pattern: r"(\d{3})",
      format: "\$1",
      leadingDigits: r"0|1(?:0[0-35-7]|1[02-5]|2[015]|3[47]|4[478])|911",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[1-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[2-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[1-8]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits:
          r"2(?:[23]02|6(?:[25]|4(?:64|[78]))|9(?:[02356]|4(?:[0268]|5[2-6])|72|8[23]))|3(?:3[28]|4(?:[04679]|3(?:5(?:4[0-25689]|[56])|[78])|58|8[2379])|5(?:[2467]|3[237]|8(?:[23]|4(?:[45]|60)|5(?:4[0-39]|5|64)))|7[1-578]|8(?:[2469]|3[278]|54(?:4|5[13-7]|6[89])|86[3-6]))|2(?:2[24-9]|3[1-59]|47)|38(?:[58][78]|7[378])|3(?:454|85[56])[46]|3(?:4(?:36|5[56])|8(?:[38]5|76))[4-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[68]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits: r"[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{2})(\d{4})",
      format: "\$2 15-\$3-\$4",
      leadingDigits:
          r"9(?:2(?:[23]02|6(?:[25]|4(?:64|[78]))|9(?:[02356]|4(?:[0268]|5[2-6])|72|8[23]))|3(?:3[28]|4(?:[04679]|3(?:5(?:4[0-25689]|[56])|[78])|5(?:4[46]|8)|8[2379])|5(?:[2467]|3[237]|8(?:[23]|4(?:[45]|60)|5(?:4[0-39]|5|64)))|7[1-578]|8(?:[2469]|3[278]|5(?:4(?:4|5[13-7]|6[89])|[56][46]|[78])|7[378]|8(?:6[3-6]|[78]))))|92(?:2[24-9]|3[1-59]|47)|93(?:4(?:36|5[56])|8(?:[38]5|76))[4-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{4})(\d{4})",
      format: "\$2 15-\$3-\$4",
      leadingDigits: r"91",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{5})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})(\d{4})",
      format: "\$2 15-\$3-\$4",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]0",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"2|3[12]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"1|47",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[3-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AW": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[25-9]",
    ),
  ],
  "AU": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"16",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"13",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"19",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"1802",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"19",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"16",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"14|4",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2378]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1(?:30|[89])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"130",
    ),
  ],
  "AT": [
    PhoneNumberFormat(pattern: r"(\d{4})", format: "\$1", leadingDigits: r"14"),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3,12})",
      format: "\$1 \$2",
      leadingDigits: r"1(?:11|[2-9])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})",
      format: "\$1 \$2",
      leadingDigits: r"517",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,5})",
      format: "\$1 \$2",
      leadingDigits: r"5[079]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"[18]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,10})",
      format: "\$1 \$2",
      leadingDigits: r"(?:31|4)6|51|6(?:485|5[0-3579]|[6-9])|7(?:20|32|8)|[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,9})",
      format: "\$1 \$2",
      leadingDigits: r"[2-467]|5[2-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4,7})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AZ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"90",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"1[28]|2|365(?:4|5[02])|46",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[13-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "BH": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[13679]|8[02-4679]",
    ),
  ],
  "BD": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4,6})",
      format: "\$1-\$2",
      leadingDigits: r"31[5-8]|[459]1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,7})",
      format: "\$1-\$2",
      leadingDigits:
          r"3(?:[67]|8[013-9])|4(?:6[168]|7|[89][18])|5(?:6[128]|9)|6(?:[15]|28|4[14])|7[2-589]|8(?:0[014-9]|[12])|9[358]|(?:3[2-5]|4[235]|5[2-578]|6[0389]|76|8[3-7]|9[24])1|(?:44|66)[01346-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,6})",
      format: "\$1-\$2",
      leadingDigits: r"[13-9]|2[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7,8})",
      format: "\$1-\$2",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "BY": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"800",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"800",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{3})",
      format: "\$1 \$2-\$3",
      leadingDigits:
          r"1(?:5[169]|6(?:3[1-3]|4|5[125])|7(?:1[3-9]|7[0-24-6]|9[2-7]))|2(?:1[35]|2[34]|3[3-5])",
      nationalPrefixFormattingRule: "\$NP 0\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2-\$3-\$4",
      leadingDigits: r"1(?:[56]|7[467])|2[1-3]",
      nationalPrefixFormattingRule: "\$NP 0\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2-\$3-\$4",
      leadingDigits: r"[1-4]",
      nationalPrefixFormattingRule: "\$NP 0\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
  ],
  "BE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"(?:80|9)0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[239]|4[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[15-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"4",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "BZ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[2-8]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})(\d{3})",
      format: "\$1-\$2-\$3-\$4",
      leadingDigits: r"0",
    ),
  ],
  "BJ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"0",
    ),
  ],
  "BT": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"[2-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-6]|7[246]|8[2-4]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"1[67]|[78]",
    ),
  ],
  "BO": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[23]|4[46]|50",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{8})",
      format: "\$1",
      leadingDigits: r"[5-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "BA": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1-\$2",
      leadingDigits: r"[2-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6[1-3]|[7-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2-\$3",
      leadingDigits: r"[3-5]|6[56]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "BW": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"90",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[24-6]|3[15-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[37]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "BR": [
    PhoneNumberFormat(
      pattern: r"(\d{3,6})",
      format: "\$1",
      leadingDigits:
          r"1(?:1[25-8]|2[357-9]|3[02-68]|4[12568]|5|6[0-8]|8[015]|9[0-47-9])|321|610",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"300|4(?:0(?:0|20)|370|864)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[2357]|4(?:[0-24-9]|3(?:[0-689]|7[1-9]))",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2,3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"(?:[358]|90)0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits:
          r"(?:[14689][1-9]|2[12478]|3[1-578]|5[13-5]|7[13-579])[2-57]",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits: r"[16][1-9]|[2-57-9]",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
  ],
  "IO": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"3",
    ),
  ],
  "BN": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-578]",
    ),
  ],
  "BG": [
    PhoneNumberFormat(pattern: r"(\d{6})", format: "\$1", leadingDigits: r"1"),
    PhoneNumberFormat(
      pattern: r"(\d)(\d)(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"43[1-6]|70[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[356]|4[124-7]|7[1-9]|8[1-6]|9[1-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"(?:70|8)0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"43[1-7]|7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[48]|9[08]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "BF": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[024-7]",
    ),
  ],
  "BI": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2367]",
    ),
  ],
  "KH": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "CM": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"88",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"[26]|88",
    ),
  ],
  "CV": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-589]",
    ),
  ],
  "CF": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[26-8]",
    ),
  ],
  "TD": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[236-9]",
    ),
  ],
  "CL": [
    PhoneNumberFormat(
      pattern: r"(\d{4})",
      format: "\$1",
      leadingDigits: r"1(?:[03-589]|21)|[29]0|78",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"2196",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"60|809",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"44",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2[1-36]",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9(?:10|[2-9])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"3[2-5]|[47]|5[1-3578]|6[13-57]|8(?:0[1-8]|[1-9])",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"60|8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"60",
    ),
  ],
  "CN": [
    PhoneNumberFormat(
      pattern: r"(\d{5,6})",
      format: "\$1",
      leadingDigits: r"1(?:00|2(?:1|395))|9[56]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5,6})",
      format: "\$1",
      leadingDigits: r"1(?:0|23(?:[0-8]|9[0-46-9]))|78123|[1-9]123",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits:
          r"10(?:1(?:0|23)|9[56])|2[0-57-9](?:1(?:00|23)|9[56])|(?:3(?:[157]\d|35|49|9[1-68])|4(?:1[124-9]|2[179]|[35][1-9]|6[47-9]|7\d|8[23])|5(?:[1357]\d|2[37]|4[36]|6[1-46]|80|9[1-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[1579]\d|2[248]|3[014-9]|4[3-6]|6[023689])|8(?:078|1[236-8]|2[5-7]|[37]\d|5[1-9]|8[36-8]|9[1-8])|9(?:0[1-3689]|1[1-79]|3\d|4[13]|5[1-5]|7[0-79]|9[0-35-9]))123",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits:
          r"1(?:0(?:[02-8]|1(?:[013-9]|2[0-24-9])|9[0-47-9])|[1-9])|2(?:[0-57-9](?:[02-8]|1(?:0[1-9]|[13-9]|2[0-24-9])|9[0-47-9])|6)|3(?:[0268]|3[0-46-9]|4[0-8]|9[079])|4(?:[049]|1[03]|2[02-68]|[35]0|6[0-356]|8[014-9])|5(?:0|2[0-24-689]|4[0-2457-9]|6[057-9]|8[1-9]|90)|6(?:[0-24578]|3[06-9]|6[14-79]|9[03-9])|7(?:0[02-9]|2[0135-79]|3[23]|4[0-27-9]|6[1457]|8)|8(?:0(?:[0-689]|7[0-79])|1[01459]|2[0-489]|[46]|50|8[0-2459]|9[09])|9(?:0[0457]|1[08]|[268]|4[024-9]|5[06-9]|78|94)|(?:3(?:[157]\d|35|49|9[1-68])|4(?:1[124-9]|2[179]|[35][1-9]|6[47-9]|7\d|8[23])|5(?:[1357]\d|2[37]|4[36]|6[1-46]|80|9[1-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[1579]\d|2[248]|3[014-9]|4[3-6]|6[023689])|8(?:078|1[236-8]|2[5-7]|[37]\d|5[1-9]|8[36-8]|9[1-8])|9(?:0[1-3689]|1[1-79]|3\d|4[13]|5[1-5]|7[0-79]|9[0-35-9]))(?:[02-9]|1(?:[013-9]|2[0-24-9]))",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"16[08]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits:
          r"85[23](?:100|95)|(?:3(?:[157]\d|35|49|9[1-68])|4(?:[17]\d|2[179]|[35][1-9]|6[47-9]|8[23])|5(?:[1357]\d|2[37]|4[36]|6[1-46]|80|9[1-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[1579]\d|2[248]|3[014-9]|4[3-6]|6[023689])|8(?:1[236-8]|2[5-7]|[37]\d|5[14-9]|8[36-8]|9[1-8])|9(?:0[1-3689]|1[1-79]|[379]\d|4[13]|5[1-5]))(?:100|9[56])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits:
          r"1(?:0[02-8]|[1-9])|2(?:[0-57-9][0-8]|6)|3(?:[0268]|3[0-46-9]|4[0-8]|9[079])|4(?:[049]|2[02-68]|[35]0|6[0-356]|8[014-9])|5(?:0|2[0-24-689]|4[0-2457-9]|6[057-9]|90)|6(?:[0-24578]|3[06-9]|6[14-79]|9[03-9])|7(?:0[02-9]|2[0135-79]|3[23]|4[0-27-9]|6[1457]|8)|8(?:[046]|1[01459]|2[0-489]|5(?:0|[23](?:[02-8]|1[1-9]|9[0-46-9]))|8[0-2459]|9[09])|9(?:0[0457]|1[08]|[268]|4[024-9]|5[06-9])|(?:10|2[0-57-9])9[0-47-9]|(?:101|58|85[23]10)[1-9]|(?:3(?:[157]\d|35|49|9[1-68])|4(?:[17]\d|2[179]|[35][1-9]|6[47-9]|8[23])|5(?:[1357]\d|2[37]|4[36]|6[1-46]|80|9[1-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[1579]\d|2[248]|3[014-9]|4[3-6]|6[023689])|8(?:1[236-8]|2[5-7]|[37]\d|5[14-9]|8[36-8]|9[1-8])|9(?:0[1-3689]|1[1-79]|[379]\d|4[13]|5[1-5]))(?:[02-8]|1(?:0[1-9]|[1-9])|9[0-47-9])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"(?:4|80)0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"10[0-79]|2(?:[02-57-9]|1[1-79])|(?:10|21)8(?:0[1-9]|[1-9])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"3(?:[3-59]|7[02-68])|4(?:[26-8]|3[3-9]|5[2-9])|5(?:3[03-9]|[468]|7[028]|9[2-46-9])|6|7(?:[0-247]|3[04-9]|5[0-4689]|6[2368])|8(?:[1-358]|9[1-7])|9(?:[013479]|5[1-5])|(?:[34]1|55|79|87)[02-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7,8})",
      format: "\$1 \$2",
      leadingDigits: r"9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"80",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[3-578]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1[3-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[12]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "CO": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"46",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"6|90",
      nationalPrefixFormattingRule: "(\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"3[0-357]|9[14]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{7})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "KM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[3478]",
    ),
  ],
  "CG": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[02]",
    ),
  ],
  "CD": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"88",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[1-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "CK": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"[2-578]",
    ),
  ],
  "CR": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-7]|8[3-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[89]",
    ),
  ],
  "HR": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6[01]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6|7[245]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-57]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "CU": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4,6})",
      format: "\$1 \$2",
      leadingDigits: r"2[1-4]|[34]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{6,7})",
      format: "\$1 \$2",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[56]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "CW": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[3467]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9[4-8]",
    ),
  ],
  "CY": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[257-9]",
    ),
  ],
  "CZ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-8]|9[015-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"96",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"9",
    ),
  ],
  "CI": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d)(\d{5})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"2",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
  ],
  "DK": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2-9]",
    ),
  ],
  "DJ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[27]",
    ),
  ],
  "EC": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[2-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2-\$3",
      leadingDigits: r"[2-7]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "EG": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7,8})",
      format: "\$1 \$2",
      leadingDigits: r"[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6,7})",
      format: "\$1 \$2",
      leadingDigits: r"1[35]|[4-6]|8[2468]|9[235-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{8})",
      format: "\$1 \$2",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SV": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[89]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[25-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
    ),
  ],
  "GQ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[235]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[89]",
    ),
  ],
  "ER": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[178]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "EE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits:
          r"[369]|4[3-8]|5(?:[02]|1(?:[0-8]|95)|5[0-478]|6(?:4[0-4]|5[1-589]))|7[1-9]|88",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"[45]|8(?:00[1-9]|[1-49])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "SZ": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[0237]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"9",
    ),
  ],
  "ET": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-57-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "FO": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-9]",
    ),
  ],
  "FJ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[235-9]|45",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0",
    ),
  ],
  "FI": [
    PhoneNumberFormat(
      pattern: r"(\d{5})",
      format: "\$1",
      leadingDigits: r"75[12]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})",
      format: "\$1",
      leadingDigits: r"20[2-59]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(pattern: r"(\d{6})", format: "\$1", leadingDigits: r"11"),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,7})",
      format: "\$1 \$2",
      leadingDigits: r"(?:[1-3]0|[68])0|70[07-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4,8})",
      format: "\$1 \$2",
      leadingDigits: r"[14]|2[09]|50|7[135]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6,10})",
      format: "\$1 \$2",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4,9})",
      format: "\$1 \$2",
      leadingDigits: r"(?:19|[2568])[1-8]|3(?:0[1-9]|[1-9])|9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "FR": [
    PhoneNumberFormat(pattern: r"(\d{4})", format: "\$1", leadingDigits: r"10"),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"[1-79]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "GF": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[5-7]|80[6-9]|9[47]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "PF": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"44",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"4|8[7-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
    ),
  ],
  "GA": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2-7]",
      nationalPrefixFormattingRule: "0\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"11|[67]",
      nationalPrefixFormattingRule: "0\$FG",
    ),
  ],
  "GM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[235-9]|4(?:[0-35]|4[16-9])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[48]",
    ),
  ],
  "GE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"70",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"32",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[57]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[348]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "DE": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,13})",
      format: "\$1 \$2",
      leadingDigits: r"3[02]|40|[68]9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"2277",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,12})",
      format: "\$1 \$2",
      leadingDigits:
          r"2(?:0[1-389]|12[0-8])|3(?:[35-9][15]|4[015])|906|2(?:[13][14]|2[18])|(?:2[4-9]|4[2-9]|[579][1-9]|[68][1-8])1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2,11})",
      format: "\$1 \$2",
      leadingDigits:
          r"[24-6]|3(?:3(?:0[1-467]|2[127-9]|3[124578]|7[1257-9]|8[1256]|9[145])|4(?:2[135]|4[13578]|9[1346])|5(?:0[14]|2[1-3589]|6[1-4]|7[13468]|8[13568])|6(?:2[1-489]|3[124-6]|6[13]|7[12579]|8[1-356]|9[135])|7(?:2[1-7]|4[145]|6[1-5]|7[1-4])|8(?:21|3[1468]|6|7[1467]|8[136])|9(?:0[12479]|2[1358]|4[134679]|6[1-9]|7[136]|8[147]|9[1468]))|70[2-8]|8(?:0[2-9]|[1-8])|90[7-9]|[79][1-9]|3[68]4[1347]|3(?:47|60)[1356]|3(?:3[46]|46|5[49])[1246]|3[4579]3[1357]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"138",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{2,10})",
      format: "\$1 \$2",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,11})",
      format: "\$1 \$2",
      leadingDigits: r"181",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{4,10})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1(?:3|80)|9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7,8})",
      format: "\$1 \$2",
      leadingDigits: r"1[67]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7,12})",
      format: "\$1 \$2",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"18500",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"18[68]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"15[1279]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"15(?:[0568]|3[13])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{8})",
      format: "\$1 \$2",
      leadingDigits: r"18",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{7,8})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1(?:6[023]|7)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{7})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"15[279]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{8})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"15",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "GH": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[237]|8[0-2]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2358]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "GI": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"2",
    ),
  ],
  "GR": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"21|7",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})",
      format: "\$1 \$2",
      leadingDigits:
          r"2(?:2|3[2-57-9]|4[2-469]|5[2-59]|6[2-9]|7[2-69]|8[2-49])|5",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2689]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})(\d{5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "GL": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"19|[2-9]",
    ),
  ],
  "GP": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[5-79]|80[6-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "GT": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-8]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "GN": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"3",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[67]",
    ),
  ],
  "GW": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"40",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[49]",
    ),
  ],
  "GY": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-9]",
    ),
  ],
  "HT": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-589]",
    ),
  ],
  "HN": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[237-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "HK": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2,5})",
      format: "\$1 \$2",
      leadingDigits: r"9003",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-7]|8[1-4]|9(?:0[1-9]|[1-8])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"9",
    ),
  ],
  "HU": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "(\$NP \$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[27][2-9]|3[2-7]|4[24-9]|5[2-79]|6|8[2-57-9]|9[2-69]",
      nationalPrefixFormattingRule: "(\$NP \$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-9]",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
  ],
  "IS": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[4-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"3",
    ),
  ],
  "IN": [
    PhoneNumberFormat(
      pattern: r"(\d{7})",
      format: "\$1",
      leadingDigits: r"575",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{8})",
      format: "\$1",
      leadingDigits: r"5(?:0|2(?:21|3)|3(?:0|3[23])|616|717|8888)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits: r"1800",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"140",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"11|2[02]|33|4[04]|79(?:[124-6]|3(?:[02-9]|1[0-24-9]))|80(?:[2-4]|6[0-589])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"1(?:2[0-24]|3[0-25]|4[145]|[59][14]|6[1-9]|7[1257]|8[1-57-9])|2(?:1[257]|3[013]|4[01]|5[0137]|6[058]|78|8[1568]|9[14])|3(?:26|4[1-3]|5[34]|6[01489]|7[02-46]|8[159])|4(?:1[36]|2[1-47]|3[15]|5[12]|6[0-26-9]|7[0-24-9]|8[013-57]|9[014-7])|5(?:1[025]|22|[36][25]|4[28]|[578]1|9[15])|6(?:12(?:[2-6]|7[0-8])|74[2-7])|7(?:3171|5[15][2-6]|61[346]|88(?:[2-7]|82))|8(?:70[2-6]|84(?:[2356]|7[19])|91(?:[3-6]|7[19]))|73[134][2-6]|8(?:16|2[014]|3[126]|6[136]|7[78]|83)(?:[2-6]|7[19])|(?:1(?:29|60|8[06])|261|552|6(?:[2-4]1|5[17]|6[13]|7(?:1|4[0189])|80)|7(?:12|88[01]))[2-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"1(?:[2-479]|5(?:[0236-9]|5[013-9]))|[2-5]|6(?:2(?:84|95)|355|8(?:28[235-7]|3))|73179|807(?:1|9[1-3])|(?:1552|6(?:(?:1[1358]|2[2457]|3[2-4]|4[235-7]|5[2-689]|6[24578])\d|7(?:[23569]\d|8[0-57-9])|8(?:[14-6]\d|2[0-79]))|7(?:1(?:[013-8]\d|9[6-9])|3(?:2[0-49]|9[2-57])|5(?:2[1-3]|9[0-6])|6(?:0[5689]|2[5-9]|3[02-8]|4\d|5[0-367])|70[13-7]))[2-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"16|[6-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"18[06]0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"18",
    ),
  ],
  "ID": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"15",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5,9})",
      format: "\$1 \$2",
      leadingDigits: r"2[124]|[36]1",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,7})",
      format: "\$1 \$2",
      leadingDigits: r"800",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,8})",
      format: "\$1 \$2",
      leadingDigits: r"[2-79]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})(\d{3})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"8[1-35-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6,8})",
      format: "\$1 \$2",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"804",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"80",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4,5})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})(\d{2,8})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"001",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
  ],
  "IR": [
    PhoneNumberFormat(
      pattern: r"(\d{4,5})",
      format: "\$1",
      leadingDigits: r"96",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits:
          r"(?:1[137]|2[13-68]|3[1458]|4[145]|5[1468]|6[16]|7[1467]|8[13467])[12689]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "IQ": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "IE": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"2[24-9]|47|58|6[237-9]|9[35-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[45]0",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2569]|4[1-69]|7[14]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"70",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"81",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[78]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"4",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "IL": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})",
      format: "\$1-\$2",
      leadingDigits: r"125",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{2})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"121",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[2-489]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[57]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"12",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})",
      format: "\$1-\$2",
      leadingDigits: r"159",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})(\d{3})",
      format: "\$1-\$2-\$3-\$4",
      leadingDigits: r"1[7-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{1,2})(\d{3})(\d{4})",
      format: "\$1-\$2 \$3-\$4",
      leadingDigits: r"15",
    ),
  ],
  "IT": [
    PhoneNumberFormat(
      pattern: r"(\d{4,5})",
      format: "\$1",
      leadingDigits: r"1(?:0|9(?:2[2-9]|[46]))",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"1(?:1|92)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4,6})",
      format: "\$1 \$2",
      leadingDigits: r"0[26]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,6})",
      format: "\$1 \$2",
      leadingDigits: r"0[13-57-9][0159]|8(?:03|4[17]|9(?:2|3[04]|[45][0-4]))",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2,6})",
      format: "\$1 \$2",
      leadingDigits: r"0(?:[13-579][2-46-8]|8[236-8])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"894",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0[26]|5",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1(?:44|[679])|[378]|43",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0[13-57-9][0159]|14",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0[26]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4,5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[03]",
    ),
  ],
  "JP": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"00777[01]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{8,10})",
      format: "\$1",
      leadingDigits: r"000",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"(?:12|57|99)0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d)(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits:
          r"1(?:267|3(?:7[247]|9[278])|466|5(?:47|58|64)|6(?:3[245]|48|5[4-68]))|499[2468]|5(?:769|979[2-69])|7468|8(?:3(?:8[7-9]|96[2457-9])|477|51[2-9])|9(?:802|9(?:1[23]|69))|1(?:45|58)[67]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"60",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"3|4(?:2(?:0|9[02-69])|7(?:0[019]|1))|6[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits:
          r"1(?:1|5(?:4[018]|5[017])|77|88|9[69])|2(?:2[127]|3[0-269]|4[59]|5(?:[1-3]|5[0-69]|9(?:17|99))|6(?:2|4[016-9])|7(?:[1-35]|8[0189])|8(?:[16]|3[0134]|9[0-5])|9(?:[028]|17))|4(?:2(?:[13-79]|8[014-6])|3[0-57]|[45]|6[248]|7[2-47]|9[29])|5(?:2|3(?:[045]|9(?:[0-58]|6[4-9]|7[0-35689]))|4[0-369]|5[29]|8[02389]|9[0-3])|7(?:2[02-46-9]|34|[58]|6[0249]|7[57]|9(?:[23]|4[0-59]|5[01569]|6[0167]))|8(?:2(?:[1258]|4[0-39]|9[0169])|3(?:[29]|60|7(?:[017-9]|6[6-8]))|49|51|6(?:[0-24]|36[2-57-9]|5(?:[0-389]|5[23])|6(?:[01]|9[178])|7(?:2[2-468]|3[78])|9[0145])|7[0-468]|8[68])|9(?:4[15]|5[138]|7[156]|8[189]|9(?:[1289]|3(?:31|4[357])|4[0178]))|(?:8294|96)[1-3]|2(?:57|93)[015-9]|(?:223|8699)[014-9]|(?:25[0468]|422|838)[01]|(?:48|8292|9[23])[1-9]|(?:47[59]|59[89]|8(?:68|9))[019]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[14]|[289][2-9]|5[3-9]|7[2-4679]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{3,4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"0077",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"008",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"800",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[25-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3,4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})(\d{4,5})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})(\d{5,6})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})(\d{6,7})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"0",
    ),
  ],
  "JO": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2356]|87",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"70",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[47]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "KE": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5,7})",
      format: "\$1 \$2",
      leadingDigits: r"[24-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[17]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "XK": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-4]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2|39",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7,10})",
      format: "\$1 \$2",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "KW": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"[169]|2(?:[235]|4[1-35-9])|52",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[245]",
    ),
  ],
  "KG": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"3(?:1[346]|[24-79])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[235-79]|88",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d)(\d{2,3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "LA": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2[13]|3[14]|[4-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "LV": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2679]|8[01]",
    ),
  ],
  "LB": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[13-69]|7(?:[2-57]|62|8[0-6]|9[04-9])|8[02-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[27-9]",
    ),
  ],
  "LS": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2568]",
    ),
  ],
  "LR": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"4[67]|[56]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-578]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "LY": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1-\$2",
      leadingDigits: r"[2-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "LI": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2379]|8(?:0(?:02|9)|7)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"69",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6",
    ),
  ],
  "LT": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"52[0-7]",
      nationalPrefixFormattingRule: "(\$NP-\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[7-9]",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"37|4(?:[15]|6[1-8])",
      nationalPrefixFormattingRule: "(\$NP-\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[3-6]",
      nationalPrefixFormattingRule: "(\$NP-\$FG)",
    ),
  ],
  "LU": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})",
      format: "\$1 \$2",
      leadingDigits:
          r"2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"2(?:0[2-689]|[2-9])|[3-57]|8(?:0[2-9]|[13-9])|9(?:0[89]|[2-579])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"20[2-689]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{1,2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"20",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{1,5})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[3-57]|8[13-9]|9(?:0[89]|[2-579])|(?:2|80)[2-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"80[01]|90[015]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"20",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})(\d{1,2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"20",
    ),
  ],
  "MO": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[268]",
    ),
  ],
  "MG": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MW": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1[2-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[1-37-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MY": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"[4-79]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"1(?:[02469]|[37][1-9]|53|8(?:[1-46-9]|5[7-9]))|8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{2})(\d{4})",
      format: "\$1-\$2-\$3-\$4",
      leadingDigits: r"1(?:[367]|80)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"15",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MV": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[34679]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
    ),
  ],
  "ML": [
    PhoneNumberFormat(
      pattern: r"(\d{4})",
      format: "\$1",
      leadingDigits: r"67(?:0[09]|[59]9|77|8[89])|74(?:0[02]|44|55)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[24-9]",
    ),
  ],
  "MT": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2357-9]",
    ),
  ],
  "MH": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[2-6]",
    ),
  ],
  "MQ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[5-79]|8(?:0[6-9]|[36])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MR": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2-48]",
    ),
  ],
  "MU": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-46]|8[013]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[57]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"8",
    ),
  ],
  "MX": [
    PhoneNumberFormat(pattern: r"(\d{5})", format: "\$1", leadingDigits: r"53"),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"33|5[56]|81",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-9]",
    ),
  ],
  "FM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[389]",
    ),
  ],
  "MD": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"22|3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[25-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MC": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"87",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"4",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[389]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"[67]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MN": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"11|2[16]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[5-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits: r"[12]2[1-3]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits: r"[12](?:27|3[2-8]|4[2-68]|5[1-4689])[0-3]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits: r"[12]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "ME": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MA": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1-\$2",
      leadingDigits: r"892",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1-\$2",
      leadingDigits: r"8(?:0[0-7]|9)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"[5-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MZ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2|8[2-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "MM": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"16|2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"4(?:[2-46]|5[3-5])|5|6(?:[1-689]|7[235-7])|7(?:[0-4]|5[2-7])|8[1-5]|(?:60|86)[23]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[12]|452|6788|86",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[4-7]|8[1-35]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4,6})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9(?:2[0-4]|[35-9]|4[137-9])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"92",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{5})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NA": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"88",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"87",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NR": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[24-9]",
    ),
  ],
  "NP": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7})",
      format: "\$1-\$2",
      leadingDigits: r"1[2-6]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1-\$2",
      leadingDigits: r"1[01]|[2-8]|9(?:[1-59]|[67][2-6])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1-\$2",
      leadingDigits: r"9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{5})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"1",
    ),
  ],
  "NL": [
    PhoneNumberFormat(
      pattern: r"(\d{4})",
      format: "\$1",
      leadingDigits: r"1[238]|[34]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"14",
    ),
    PhoneNumberFormat(pattern: r"(\d{6})", format: "\$1", leadingDigits: r"1"),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4,7})",
      format: "\$1 \$2",
      leadingDigits: r"[89]0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"66",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{8})",
      format: "\$1 \$2",
      leadingDigits: r"6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1[16-8]|2[259]|3[124]|4[17-9]|5[124679]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-578]|91",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NC": [
    PhoneNumberFormat(
      pattern: r"(\d{3})",
      format: "\$1",
      leadingDigits: r"5[6-8]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1.\$2.\$3",
      leadingDigits: r"[02-57-9]",
    ),
  ],
  "NZ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,8})",
      format: "\$1 \$2",
      leadingDigits: r"8[1-79]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"50(?:[0367]|88)|8|90",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"24|[346]|7[2-57-9]|9[2-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2(?:10|74)|[589]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1|2[028]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2(?:[169]|7[0-35-9])|7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NI": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[125-8]",
    ),
  ],
  "NE": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"08",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[089]|2[013]|7[0467]",
    ),
  ],
  "NG": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[7-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"20[129]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{4,5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[78]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})(\d{5,6})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[78]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NU": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"8",
    ),
  ],
  "NF": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"1[0-3]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"[13]",
    ),
  ],
  "KP": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-7]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "MK": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2|34[47]|4(?:[37]7|5[47]|64)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[347]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[58]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "NO": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2-79]",
    ),
  ],
  "OM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4,6})",
      format: "\$1 \$2",
      leadingDigits: r"[58]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"2",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[179]",
    ),
  ],
  "PK": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2,7})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6,7})",
      format: "\$1 \$2",
      leadingDigits:
          r"9(?:2[3-8]|98)|(?:2(?:3[2358]|4[2-4]|9[2-8])|45[3479]|54[2-467]|60[468]|72[236]|8(?:2[2-689]|3[23578]|4[3478]|5[2356])|9(?:22|3[27-9]|4[2-6]|6[3569]|9[25-7]))[2-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7,8})",
      format: "\$1 \$2",
      leadingDigits:
          r"(?:2[125]|4[0-246-9]|5[1-35-7]|6[1-8]|7[14]|8[16]|91)[2-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"58",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"2[125]|4[0-246-9]|5[1-35-7]|6[1-8]|7[14]|8[16]|91",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[24-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
  ],
  "PW": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-9]",
    ),
  ],
  "PS": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2489]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "PA": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[1-57-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[68]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "PG": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"18|[2-69]|85[02-46-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[78]",
    ),
  ],
  "PY": [
    PhoneNumberFormat(
      pattern: r"(\d{6,7})",
      format: "\$1",
      leadingDigits: r"[125]|4[01]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,6})",
      format: "\$1 \$2",
      leadingDigits: r"[2-9]0",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"3[289]|4[246-8]|61|7[1-3]|8[1-36]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits: r"2[279]|3[13-5]|4[359]|5|6(?:[34]|7[1-46-8])|7[46-8]|85",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2[14-68]|3[26-9]|4[1246-8]|6(?:1|75)|7[1-35]|8[1-36]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"87",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"9(?:[5-79]|8[1-7])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
    ),
  ],
  "PE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"80",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[4-8]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
    ),
  ],
  "PH": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4,6})",
      format: "\$1 \$2",
      leadingDigits:
          r"3(?:230|397|461)|4(?:2(?:35|[46]4|51)|396|4(?:22|63)|59[347]|76[15])|5(?:221|446)|642[23]|8(?:622|8(?:[24]2|5[13]))",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"3469|4(?:279|9(?:30|56))|8834",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[3-7]|8[2-8]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{1,2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"1",
    ),
  ],
  "PL": [
    PhoneNumberFormat(pattern: r"(\d{5})", format: "\$1", leadingDigits: r"19"),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"11|20|64",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"30|(?:1[2-8]|2[2-69]|3[2-4]|4[1-468]|5[24-689]|6[1-3578]|7[14-7]|8[1-79]|9[145])19",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"64",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"21|39|45|5[0137]|6[0469]|7[02389]|8(?:0[14]|8)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"1[2-8]|[2-7]|8[1-79]|9[145]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "PT": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2[12]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"16|[236-9]",
    ),
  ],
  "QA": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"2[136]|8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[3-7]",
    ),
  ],
  "RO": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"2[3-6]\d9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"219|31",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[23]1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[236-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "RU": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[0-79]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits:
          r"7(?:1(?:[0-356]2|4[29]|7|8[27])|2(?:13[03-69]|62[013-9]))|72[1-57-9]2",
      nationalPrefixFormattingRule: "\$NP (\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d)(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits:
          r"7(?:1(?:0(?:[356]|4[023])|[18]|2(?:3[013-9]|5)|3[45]|43[013-79]|5(?:3[1-8]|4[1-7]|5)|6(?:3[0-35-9]|[4-6]))|2(?:1(?:3[178]|[45])|[24-689]|3[35]|7[457]))|7(?:14|23)4[0-8]|71(?:33|45)[1-79]",
      nationalPrefixFormattingRule: "\$NP (\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP (\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2-\$3-\$4",
      leadingDigits: r"[349]|8(?:[02-7]|1[1-8])",
      nationalPrefixFormattingRule: "\$NP (\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP (\$FG)",
    ),
  ],
  "RW": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[7-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "RE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[26-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "WS": [
    PhoneNumberFormat(
      pattern: r"(\d{5})",
      format: "\$1",
      leadingDigits: r"[2-5]|6[1-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,7})",
      format: "\$1 \$2",
      leadingDigits: r"[68]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"7",
    ),
  ],
  "SM": [
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"[89]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[5-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"0",
    ),
  ],
  "SA": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
  ],
  "SN": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[379]",
    ),
  ],
  "RS": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,9})",
      format: "\$1 \$2",
      leadingDigits: r"(?:2[389]|39)0|[7-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5,10})",
      format: "\$1 \$2",
      leadingDigits: r"[1-36]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SC": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[246]|9[57]",
    ),
  ],
  "SL": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[236-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
  ],
  "SG": [
    PhoneNumberFormat(
      pattern: r"(\d{4,5})",
      format: "\$1",
      leadingDigits: r"1(?:[013-8]|9(?:0[1-9]|[1-9]))|77",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[369]|8(?:0[1-9]|[1-9])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "SK": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"21",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[3-5][1-8]1[67]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"9090",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[689]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[3-5]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SI": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,6})",
      format: "\$1 \$2",
      leadingDigits: r"8[09]|9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"59|8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[37][01]|4[013]|51|6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[1-57]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
  ],
  "SB": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"6[89]|7|8[4-9]|9(?:[1-8]|9[0-8])",
    ),
  ],
  "SO": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"8[125]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"[134]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[15]|2[0-79]|3[0-46-8]|4[0-7]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5,7})",
      format: "\$1 \$2",
      leadingDigits: r"1|28|9[2-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[267]|904",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[346-9]",
    ),
  ],
  "ZA": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"8[1-4]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2,3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8[1-4]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"860",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "KR": [
    PhoneNumberFormat(
      pattern: r"(\d{5})",
      format: "\$1",
      leadingDigits: r"1[016-9]114",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})",
      format: "\$1-\$2",
      leadingDigits: r"(?:3[1-3]|[46][1-4]|5[1-5])1",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"1",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3,4})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[36]0|8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,4})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[1346]|5[1-5]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"[57]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0030",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})(\d{4})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
  ],
  "SS": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[19]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "ES": [
    PhoneNumberFormat(
      pattern: r"(\d{4})",
      format: "\$1",
      leadingDigits: r"905[124578]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{6})",
      format: "\$1",
      leadingDigits: r"[79]9",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]00",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[4-9]",
    ),
  ],
  "LK": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-689]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "PM": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SD": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[19]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SR": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1-\$2-\$3",
      leadingDigits: r"56",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1-\$2",
      leadingDigits: r"[2-5]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[6-9]",
    ),
  ],
  "SE": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2,3})(\d{2})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"20",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"9(?:00|39|44|9)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"[12][136]|3[356]|4[0246]|6[03]|90[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{2,3})(\d{2})(\d{2})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2,3})(\d{2})",
      format: "\$1-\$2 \$3",
      leadingDigits:
          r"1[2457]|2(?:[247-9]|5[0138])|3[0247-9]|4[1357-9]|5[0-35-9]|6(?:[125689]|4[02-57]|7[0-2])|9(?:[125-8]|3[02-5]|4[0-3])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2,3})(\d{3})",
      format: "\$1-\$2 \$3",
      leadingDigits: r"9(?:00|39|44)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2,3})(\d{2})(\d{2})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits: r"1[13689]|2[0136]|3[1356]|4[0246]|54|6[03]|90[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits: r"10|7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3})(\d{2})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits:
          r"[13-5]|2(?:[247-9]|5[0138])|6(?:[124-689]|7[0-2])|9(?:[125-8]|3[02-5]|4[0-3])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{3})",
      format: "\$1-\$2 \$3 \$4",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1-\$2 \$3 \$4 \$5",
      leadingDigits: r"[26]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "CH": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"8[047]|90",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[2-79]|81",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4 \$5",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "SY": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-4]|5[1-3]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[59]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "ST": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[29]",
    ),
  ],
  "TW": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d)(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"202",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"826",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"83",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"82",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[25]0|37|49|8[09]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3,4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[23568]|4(?:0[2-48]|[1-478])|(?:400|7)[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[49]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4,5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "TJ": [
    PhoneNumberFormat(
      pattern: r"(\d{6})(\d)(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"3317",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"44[02-479]|[34]7",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d)(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"3(?:[1245]|3[12])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"\d",
    ),
  ],
  "TZ": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[24]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"5",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[67]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "TH": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[13-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"1",
    ),
  ],
  "TL": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[2-489]|70",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"7",
    ),
  ],
  "TG": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[279]",
    ),
  ],
  "TO": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})",
      format: "\$1-\$2",
      leadingDigits: r"[2-4]|50|6[09]|7[0-24-69]|8[05]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[5-9]",
    ),
  ],
  "TN": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[2-57-9]",
    ),
  ],
  "TM": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2-\$3-\$4",
      leadingDigits: r"12",
      nationalPrefixFormattingRule: "(\$NP \$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{2})(\d{2})",
      format: "\$1 \$2-\$3-\$4",
      leadingDigits: r"[1-5]",
      nationalPrefixFormattingRule: "(\$NP \$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"[67]",
      nationalPrefixFormattingRule: "\$NP \$FG",
    ),
  ],
  "TV": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"2",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"90",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"7",
    ),
  ],
  "TR": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"444",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"512|8[01589]|90",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[24][1-8]|3[1-9]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{6,7})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"80",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "UG": [
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1 \$2",
      leadingDigits: r"20240",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"20(?:[0135-7]|2[5-9])|4(?:6[45]|[7-9])|[7-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[2-4]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "UA": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits:
          r"6[12][29]|(?:35|4[1378]|5[12457]|6[49])2|(?:56|65)[24]|(?:3[1-46-8]|46)2[013-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5})",
      format: "\$1 \$2",
      leadingDigits:
          r"3[1-8]|4(?:[1367]|[45][6-9]|8[4-6])|5(?:[1-5]|6(?:[015689]|3[02389])|7[4-6])|6(?:[12][3-7]|[459])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[3-7]|89|9[1-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[89]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "AE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2,9})",
      format: "\$1 \$2",
      leadingDigits: r"60|8",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[236]|[479][2-8]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d)(\d{5})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[479]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"5",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "GB": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"8001111",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"845464",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"800",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{5})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits: r"1(?:3873|5(?:242|39[4-6])|(?:697|768)[347]|9467)",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{5,6})",
      format: "\$1 \$2",
      leadingDigits: r"1(?:[2-69][02-9]|[78])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[25]|7(?:0|6(?:[03-9]|2[356]))",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1389]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "US": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"310",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1-\$2",
      leadingDigits: r"[24-9]|3(?:[02-9]|1[1-9])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{4})",
      format: "(\$1) \$2-\$3",
      leadingDigits: r"[2-9]",
    ),
  ],
  "UY": [
    PhoneNumberFormat(
      pattern: r"(\d{4,5})",
      format: "\$1",
      leadingDigits: r"21",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,4})",
      format: "\$1 \$2",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[49]0|8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"9",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[124]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{2,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"0",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})(\d{2,4})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"0",
    ),
  ],
  "UZ": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"[235-9]",
    ),
  ],
  "VU": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[57-9]",
    ),
  ],
  "VE": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{7})",
      format: "\$1-\$2",
      leadingDigits: r"[24-689]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "VN": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"[17]99",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4,5})",
      format: "\$1 \$2",
      leadingDigits: r"69",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{4,6})",
      format: "\$1 \$2",
      leadingDigits: r"1(?:2[02]|[89])",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"1[26]|6",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[357-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{4})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2[48]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"2",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "WF": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[47-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{2})(\d{2})(\d{2})",
      format: "\$1 \$2 \$3 \$4",
      leadingDigits: r"8",
    ),
  ],
  "YE": [
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[1-6]|7(?:[24-6]|8[0-7])",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "ZM": [
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})",
      format: "\$1 \$2",
      leadingDigits: r"[1-9]",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[28]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[579]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
  "ZW": [
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3,5})",
      format: "\$1 \$2",
      leadingDigits: r"1|2(?:0[0-36-9]|29|58)|67[0-46-9]|(?:55|68)[0-69]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3,5})",
      format: "\$1 \$2",
      leadingDigits: r"2(?:0[45]|[27]|48)|37|675|(?:55|68)[78]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d)(\d{3})(\d{2,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"[49]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{4})",
      format: "\$1 \$2",
      leadingDigits: r"80",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{3,5})",
      format: "\$1 \$2",
      leadingDigits: r"548",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"29[013-9]",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{7})",
      format: "\$1 \$2",
      leadingDigits: r"[256]|39|8[13-59]",
      nationalPrefixFormattingRule: "(\$NP\$FG)",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{2})(\d{3})(\d{4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"7",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{3})(\d{3})(\d{3,4})",
      format: "\$1 \$2 \$3",
      leadingDigits: r"3",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
    PhoneNumberFormat(
      pattern: r"(\d{4})(\d{6})",
      format: "\$1 \$2",
      leadingDigits: r"8",
      nationalPrefixFormattingRule: "\$NP\$FG",
    ),
  ],
};
