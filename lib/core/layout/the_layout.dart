import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_app_bar.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({
    required this.child,
    this.backgroundColor,
    super.key});
  // --------------------
  final Widget child;
  final Color? backgroundColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colorz.majorelleBlue,
      appBar: const TheAppBar(),
      body: child,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
