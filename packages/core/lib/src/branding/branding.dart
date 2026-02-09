import 'branding_color_provider.dart';
import 'branding_colors.dart';

///This class will provide access to the branding data for company. It is implemented as singleton
///but managed by Get_it package

class Branding {
  static final Branding _instance = Branding._internal();
  static late BrandingColors _colors;
  late BrandingColorProvider _colorProvider;

  factory Branding() => _instance;

  Branding._internal();

  static BrandingColors get colors => _colors;

  void startUp({required BrandingColorProvider colorProvider, Map<String, dynamic>? colors}) {
    _colorProvider = colorProvider;
    _loadColors(colors);
  }

  ///Helper method to set branding color with associated company
  void setBrand(Map<String, dynamic>? colors) async {
    _loadColors(colors);
  }

  ///Helper method to load colors from the color provider
  void _loadColors(Map<String, dynamic>? colors) {
    final brandColors = _colorProvider.getColorsForBrand(colors);
    _colors = brandColors;
  }
}
