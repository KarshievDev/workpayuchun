import 'dart:ui';
import 'package:core/core.dart';
import 'package:core/src/branding/branding_colors.dart';

class BrandingColorProvider {
  BrandingColors getColorsForBrand(Map<String, dynamic>? colors) {
    return BrandingColors(colors: {
      BrandingColorType.primaryLight:
          _getColorFromCompany(colors, BrandingColorType.primaryLight, const Color(0xFF176B87)),
      BrandingColorType.primaryDark:
          _getColorFromCompany(colors, BrandingColorType.primaryDark, const Color(0xFF182E39)),
      BrandingColorType.cardBackgroundDefault:
          _getColorFromCompany(colors, BrandingColorType.cardBackgroundDefault, const Color(0xFF003653)),
      BrandingColorType.cardBackgroundSubdued:
          _getColorFromCompany(colors, BrandingColorType.cardBackgroundSubdued, const Color(0xFF004164)),
      BrandingColorType.textPrimary:
          _getColorFromCompany(colors, BrandingColorType.textPrimary, const Color(0xFF1C1D1F)),
      BrandingColorType.textSecondary:
          _getColorFromCompany(colors, BrandingColorType.textSecondary, const Color(0xFF2F3233)),
      BrandingColorType.textTertiary:
          _getColorFromCompany(colors, BrandingColorType.textTertiary, const Color(0xFF6D7173)),
      BrandingColorType.textHint: _getColorFromCompany(colors, BrandingColorType.textHint, const Color(0xFF84888A)),
      BrandingColorType.textDisabled:
          _getColorFromCompany(colors, BrandingColorType.textDisabled, const Color(0xFFD0D4D6)),
      BrandingColorType.textInversePrimary:
          _getColorFromCompany(colors, BrandingColorType.textInversePrimary, const Color(0xFFFCFCFC)),
      BrandingColorType.textInverseSecondary:
          _getColorFromCompany(colors, BrandingColorType.textInverseSecondary, const Color(0xFFF5F8FA)),
      BrandingColorType.textInverseTertiary:
          _getColorFromCompany(colors, BrandingColorType.textInverseTertiary, const Color(0xFFE9EDF0)),
      BrandingColorType.brandTextLink:
          _getColorFromCompany(colors, BrandingColorType.brandTextLink, const Color(0xFF0076B3)),
      BrandingColorType.iconPrimary:
          _getColorFromCompany(colors, BrandingColorType.iconPrimary, const Color(0xFF2F3233)),
      BrandingColorType.iconSecondary:
          _getColorFromCompany(colors, BrandingColorType.iconSecondary, const Color(0xFF6D7173)),
      BrandingColorType.iconDisabled:
          _getColorFromCompany(colors, BrandingColorType.iconDisabled, const Color(0xFFD0D4D6)),
      BrandingColorType.iconInverse:
          _getColorFromCompany(colors, BrandingColorType.iconInverse, const Color(0xFFFCFCFC)),
      BrandingColorType.iconAccent: _getColorFromCompany(colors, BrandingColorType.iconAccent, const Color(0xFFFD6C2B)),
      BrandingColorType.iconNavigationBar:
          _getColorFromCompany(colors, BrandingColorType.iconNavigationBar, const Color(0xFF0B7129)),
      BrandingColorType.iconAccentInactive:
          _getColorFromCompany(colors, BrandingColorType.iconAccentInactive, const Color(0xFFB3B7BA)),
      BrandingColorType.dividerPrimary:
          _getColorFromCompany(colors, BrandingColorType.dividerPrimary, const Color(0xFFD0D4D6)),
      BrandingColorType.dividerInverse:
          _getColorFromCompany(colors, BrandingColorType.dividerInverse, const Color(0xFFF7F7F7)),
      BrandingColorType.buttonDefault:
          _getColorFromCompany(colors, BrandingColorType.buttonDefault, const Color(0xFF0A7029)),
      BrandingColorType.buttonSecondary:
          _getColorFromCompany(colors, BrandingColorType.buttonSecondary, const Color(0xFFC8DF52)),
      BrandingColorType.buttonInverse:
          _getColorFromCompany(colors, BrandingColorType.buttonInverse, const Color(0xFFFFFFFF)),
      BrandingColorType.buttonDisabled:
          _getColorFromCompany(colors, BrandingColorType.buttonDisabled, const Color(0xFFDAEADF)),
      BrandingColorType.container: _getColorFromCompany(colors, BrandingColorType.container, const Color(0xFFFFFFFF)),
      BrandingColorType.containerSecondary:
          _getColorFromCompany
            (colors, BrandingColorType.containerSecondary, const Color(0xFFF7F7F7)),
    });
  }

  Color? _getColorFromCompany(Map<String, dynamic>? colors, BrandingColorType colorType, Color defaultColor) {
    final key = colorType.asString();
    final colorAsString = colors?[key];
    if (colorAsString != null && colorAsString != "") {
      return Color(int.parse(colorAsString));
    }

    return defaultColor;
  }
}
