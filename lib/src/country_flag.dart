import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';

import 'country.dart';

/// How a country flag is drawn.
enum FlagShape {
  /// The flag's natural rectangle, unclipped. The default.
  rectangle,

  /// Clipped to a circle.
  circle,

  /// Clipped to a rounded rectangle; see [CountryFlag.borderRadius].
  rounded,

  /// Clipped to a square, cropping the sides of the flag.
  square,
}

/// Draws a country's flag.
///
/// Regional-indicator emoji are used where the platform renders them, and the
/// bundled PNG flags everywhere else. Windows and most Linux font stacks have
/// no glyphs for flag emoji and would otherwise show two letters or tofu, so
/// those platforms — and the web, whose fonts vary — always get the image.
///
/// A handful of territories ship no image (Ascension and Tristan da Cunha).
/// They fall back to the emoji, and then to the ISO code, so the widget always
/// renders something identifiable rather than a blank or a wrong flag.
class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.country,
    this.shape = FlagShape.rectangle,
    this.size = 32,
    this.borderRadius,
    this.border,
    this.forceImage = false,
  });

  /// The country whose flag to draw.
  final Country country;

  /// How to clip the flag.
  final FlagShape shape;

  /// Width of the flag in logical pixels. Height follows the aspect ratio,
  /// except for [FlagShape.circle] and [FlagShape.square], which are square.
  final double size;

  /// Corner radius for [FlagShape.rounded]. Defaults to `size / 6`.
  final BorderRadius? borderRadius;

  /// Optional border drawn around the flag.
  final BoxBorder? border;

  /// Always use the bundled PNG, even where emoji would render.
  ///
  /// Useful when you need a consistent look across platforms.
  final bool forceImage;

  /// Whether this platform renders regional-indicator flag emoji reliably.
  static bool get supportsEmojiFlags {
    if (kIsWeb) return false;
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return true;
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final useImage = forceImage || !supportsEmojiFlags;
    final Widget flag = useImage ? _image() : _emoji();
    if (shape == FlagShape.rectangle && border == null) return flag;

    return Container(
      decoration: BoxDecoration(
        border: border,
        borderRadius: shape == FlagShape.circle ? null : _radius(),
        shape: shape == FlagShape.circle ? BoxShape.circle : BoxShape.rectangle,
      ),
      clipBehavior: Clip.antiAlias,
      child: flag,
    );
  }

  BorderRadius? _radius() => switch (shape) {
        FlagShape.rounded => borderRadius ?? BorderRadius.circular(size / 6),
        FlagShape.rectangle => borderRadius,
        FlagShape.square => borderRadius,
        FlagShape.circle => null,
      };

  Widget _image() {
    final square = shape == FlagShape.circle || shape == FlagShape.square;
    return Image.asset(
      'assets/flags/${country.code.toLowerCase()}.png',
      package: 'flutter_intl_phone_field',
      width: size,
      height: square ? size : null,
      fit: square ? BoxFit.cover : BoxFit.contain,
      // A missing asset must not take the whole app down with a red screen.
      errorBuilder: (context, error, stack) =>
          supportsEmojiFlags ? _emoji() : _isoCode(),
    );
  }

  Widget _emoji() => SizedBox(
        width: size,
        child: Text(
          country.flag,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: size * 0.6),
        ),
      );

  /// Last resort: the ISO code, which at least names the country.
  Widget _isoCode() => SizedBox(
        width: size,
        child: Text(
          country.code,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );
}
