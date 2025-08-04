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
  static const String banner = 'assets/banner.jpg' ;
  static const String icon = 'assets/icon.png' ;
  // -----------------------------------------------------------------------------
}
