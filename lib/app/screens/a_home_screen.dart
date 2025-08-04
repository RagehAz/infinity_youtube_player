import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';
import 'package:infinity_youtube/core/utilities/vertical_floating_list.dart';

class HomePage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePage({
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
        columnChildren: <Widget>[

          // --------------------

          TheYoutubePlayer(
            canvasWidth: context.screenWidth,
            canvasHeight: context.screenWidth * 0.7,
            // isMuted: false,
            // autoPlay: true,
            // loop: false,
            url: 'https://youtu.be/46l2HlRQHk8?si=hmnKYWLPKVGRmXqS',
          ),

          // --------------------

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
