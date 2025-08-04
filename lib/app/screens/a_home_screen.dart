import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/shared_components/super_image/super_image.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/iconz.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';
import 'package:infinity_youtube/core/utilities/vertical_floating_list.dart';

class HomeScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeScreen({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return TheLayout(
      child: VerticalFloatingList(
        width: _screenWidth,
        height: _screenHeight,
        padding: const EdgeInsets.only(
          top: Scale.appBarHeight + 10,
          // bottom: 0,
        ),
        columnChildren: const <Widget>[

          // --------------------

          SuperText(
            text: 'Click on the video link in the website to open the video',
            maxLines: 4,
            margins: 15,
            textHeight: 30,
          ),

          SuperImage(
              width: 150,
              height: 150,
              pic: Iconz.logo,
              corners: 20,
              loading: false,
          ),

          // --------------------

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
