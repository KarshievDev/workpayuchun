import 'dart:ui';
import 'package:core/core.dart';

class BrandingColors{

  final Map<BrandingColorType, Color?> colors;

  BrandingColors({required this.colors});

  Color get primaryLight => colors[BrandingColorType.primaryLight]!;
  Color get primaryDark => colors[BrandingColorType.primaryDark]!;
  Color get cardBackgroundDefault => colors[BrandingColorType.cardBackgroundDefault]!;
  Color get cardBackgroundSubdued => colors[BrandingColorType.cardBackgroundSubdued]!;
  Color get textPrimary => colors[BrandingColorType.textPrimary]!;
  Color get textSecondary => colors[BrandingColorType.textSecondary]!;
  Color get textTertiary => colors[BrandingColorType.textTertiary]!;
  Color get textHint => colors[BrandingColorType.textHint]!;
  Color get textDisabled => colors[BrandingColorType.textDisabled]!;
  Color get textInversePrimary => colors[BrandingColorType.textInversePrimary]!;
  Color get textInverseSecondary => colors[BrandingColorType.textInverseSecondary]!;
  Color get textInverseTertiary => colors[BrandingColorType.textInverseTertiary]!;
  Color get brandTextLink => colors[BrandingColorType.brandTextLink]!;
  Color get iconPrimary => colors[BrandingColorType.iconPrimary]!;
  Color get iconSecondary => colors[BrandingColorType.iconSecondary]!;
  Color get iconDisabled => colors[BrandingColorType.iconDisabled]!;
  Color get iconInverse => colors[BrandingColorType.iconInverse]!;
  Color get iconAccent => colors[BrandingColorType.iconAccent]!;
  Color get iconNavigationBar => colors[BrandingColorType.iconNavigationBar]!;
  Color get iconAccentInactive => colors[BrandingColorType.iconAccentInactive]!;
  Color get dividerPrimary => colors[BrandingColorType.dividerPrimary]!;
  Color get dividerInverse => colors[BrandingColorType.dividerInverse]!;
  Color get buttonDefault => colors[BrandingColorType.buttonDefault]!;
  Color get buttonSecondary => colors[BrandingColorType.buttonSecondary]!;
  Color get buttonInverse => colors[BrandingColorType.buttonInverse]!;
  Color get buttonDisabled => colors[BrandingColorType.buttonDisabled]!;
  Color get container => colors[BrandingColorType.container]!;
  Color get containerSecondary => colors[BrandingColorType.containerSecondary]!;
}