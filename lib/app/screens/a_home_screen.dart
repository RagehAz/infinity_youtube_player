import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/routing.dart';
import 'package:infinity_youtube/core/services/app_linker.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/fonts.dart';
import 'package:infinity_youtube/core/theme/iconz.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';

class HomeScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomeScreen({super.key});
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SuperBox(
            height: 100,
            width: 100,
            icon: Iconz.glasses,
            color: Colorz.white255,
            iconSizeFactor: 0.7,
            corners: 50,
            margins: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),

          SuperText(
            boxWidth: context.screenWidth,
            centered: false,
            appIsLTR: true,
            text: 'TO OPEN A VIDEO',
            maxLines: 4,
            margins: const EdgeInsets.symmetric(horizontal: 20),
            textHeight: 100,
            lineSpacingFactor: 0.6,
            font: InfinityFont.montreal,
          ),

          SuperText(
            boxWidth: context.screenWidth,
            centered: false,
            appIsLTR: true,
            text: "Click the video's URL link on the website.\nThen the app will pop again with the video.",
            maxLines: 5,
            margins: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            textHeight: 30,
            font: InfinityFont.regular,
          ),

        ],
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
