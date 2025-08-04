import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

extension Contexual on BuildContext {
  // -----------------------------------------------------------------------------
  bool get mounted => this.mounted;
  // -----------------------------------------------------------------------------
  FlutterView get view => View.of(this);
  MediaQueryData get mediaQuery => MediaQueryData.fromView(view);
  // --------------------
  EdgeInsets get padding => mounted == true ? mediaQuery.padding : EdgeInsets.zero;
  Size get size => mounted == true ? mediaQuery.size : Size.zero;
  EdgeInsets get screenInsets => mounted == true ? mediaQuery.viewInsets : EdgeInsets.zero;
  Size get screenSize => Size(screenWidth, screenHeight);
  // --------------------
  double get safeAreaTopPadding => mounted == true ? padding.top : 0;
  double get safeAreaBottomPadding => mounted == true ? padding.bottom : 0;
  // --------------------
  double get screenWidth => mounted == true ? size.width : 0;
  // --------------------
  double get screenHeight {
    if (mounted == true){
      return size.height
          - safeAreaTopPadding
          - safeAreaBottomPadding;
    }
    else {
      return 0;
    }
  }
  double get screenHeightGross => mounted ? size.height : 0;
  double get pageHeight => mounted == true ? (screenHeight - Scale.appBarHeight) : 0;
  // --------------------
  bool get isLandScape => mounted == true ? (MediaQuery.orientationOf(this) == Orientation.landscape) : false;
  // --------------------
  double get screenShortestSide {
    if (mounted == true){
      final bool _isLandscape = isLandScape;
      return _isLandscape ? size.height : size.width;
    }
    else {
      return 0;
    }
  }
  double get screenLongestSide {
    if (mounted == true){
      final bool _isLandscape = isLandScape;
      return _isLandscape ? size.width : size.height;
    }
    else {
      return 0;
    }
  }
  // --------------------
  double get screenAspectRatio => mounted == true ? size.aspectRatio : 1;
  double get devicePixelRatio => mounted == true ? mediaQuery.devicePixelRatio : 1;
  // -----------------------------------------------------------------------------
  EdgeInsets superInsets({
    required bool appIsLTR,
    double bottom = 0,
    double enLeft = 0,
    double enRight = 0,
    double top = 0,
  }) => Scale.superInsets(
    context: this,
    appIsLTR: appIsLTR,
    top: top,
    bottom: bottom,
    enLeft: enLeft,
    enRight: enRight,
  );
  // --------------------
  EdgeInsets superMargins({
    dynamic margin
  }) => Scale.superMargins(
      margin: margin
  );
  // --------------------
  double responsive({
    required double? landscape,
    required double? portrait,
  }) => Scale.responsive(context: this, landscape: landscape, portrait: portrait);
  // --------------------
  double adaptiveWidth({
    required double? ratio,
  }) => Scale.adaptiveWidth(this, ratio);
  // --------------------
  double adaptiveHeight({
    required double? ratio,
  }) => Scale.adaptiveHeight(this, ratio);
  // --------------------
  double superWidth({
    required double? ratio,
  }) => Scale.superWidth(this, ratio);
  // --------------------
  double getUniformRowItemWidth({
    required int? numberOfItems,
    required double? boxWidth,
    double spacing = 10,
    bool considerMargins = true,
  }) => Scale.getUniformRowItemWidth(
    boxWidth: boxWidth,
    numberOfItems: numberOfItems,
    considerMargins: considerMargins,
    spacing: spacing,
  );
  // --------------------------------------------------------------------------

  /// COLORS

  // --------------------
  bool isDarkMode() {
    if (mounted == true){
      return mediaQuery.platformBrightness == Brightness.dark;
    }
    else {
      return false;
    }
  }
// -----------------------------------------------------------------------------
}
