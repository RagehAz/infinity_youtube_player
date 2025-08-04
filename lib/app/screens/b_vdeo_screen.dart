import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';

class VideoScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoScreen({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // --------------------

          SuperText(
            boxWidth: context.screenWidth,
            text: 'Video title',
            textHeight: 30,
            margins: 10,
          ),

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
