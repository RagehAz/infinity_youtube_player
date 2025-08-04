

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

class VerticalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ScrollConfiguration(
      behavior: const AppScrollBehavior(),
      child: SingleChildScrollView(
        physics: physics,
        controller: scrollController,
        child: Container(
          width: width ?? Scale.screenWidth(context),
          constraints: BoxConstraints(
            minHeight: height ?? Scale.screenHeight(context),
          ),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: superCorners(corners: boxCorners),
              border: borderColor == null ? null :
              Border.all(
                width: 0.5,
                color: borderColor!,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
          ),
          alignment: boxAlignment,
          padding: padding,
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class AppScrollBehavior extends MaterialScrollBehavior {

  const AppScrollBehavior();
  /// LETS WINDOWS LISTEN TO SWIPES/DRAGS GESTURES
  /// AND SHOULD BE PLACED IN THE TOP MOST MATERIAL APP
  ///  return MaterialApp(
  ///    scrollBehavior: AppScrollBehavior(),
  ///    ...
  ///  );
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.mouse,
    PointerDeviceKind.touch,
    PointerDeviceKind.stylus,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.unknown,
  };

}
