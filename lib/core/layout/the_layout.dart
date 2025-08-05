import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_app_bar.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({required this.child, super.key});
  // --------------------
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorz.infinityLightGrey,
      appBar: const TheAppBar(),
      body: child,
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
