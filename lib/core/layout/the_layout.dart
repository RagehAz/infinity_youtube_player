import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_app_bar.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

class TheLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheLayout({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return Scaffold(
      /// INSETS
      resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colorz.infinityLightGrey,
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            /// BODY
            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: child,
            ),

            /// APP BAR
            const TheAppBar(),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
