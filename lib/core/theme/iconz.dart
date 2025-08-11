import 'package:flutter/services.dart';

abstract class Iconz {
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkAssetExists(String? bldrsThemeAsset) async {
    bool _exists = false;

    /// This method should check if bldrs_theme asset exists or not
    /// and to be called from the project that depends on bldrs_theme
    if (bldrsThemeAsset != null) {
      await rootBundle.load(bldrsThemeAsset).then((_) {
        _exists = true;
      }).catchError((error) {
        _exists = false;
      });
    }

    return _exists;
  }
  // --------------------
  /// artworks
  static const String logo = 'assets/logo.jpg' ;
  static const String logoPlain = 'assets/logo_plain.jpg' ;
  static const String banner = 'assets/banner.jpg' ;
  static const String iconColored = 'assets/icon.png' ;
  static const String iconWhite = 'assets/icon_white.png' ;
  static const String name = 'assets/name.png' ;
  static const String palette = 'assets/palette.png';
  static const String glasses = 'assets/glasses.png';
  // -----------------------------------------------------------------------------
}
