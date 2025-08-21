import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_app_bar.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({required this.child, this.backgroundColor, super.key});
  // --------------------
  final Widget child;
  final Color? backgroundColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colorz.majorelleBlue,
        statusBarColor: Colorz.majorelleBlue,
        systemNavigationBarDividerColor: Colorz.majorelleBlue,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colorz.majorelleBlue,
        appBar: const TheAppBar(),
        body: child,
      ),
    );
    // --------------------
  }

  // --------------------------------------------------------------------------
}
