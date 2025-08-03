part of the_youtube_player;
/// TURNED_OFF_YOUTUBE_PLAYER
class _Player extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _Player({
    required this.controller,
    required this.width,
    required this.corners,
    // super.key
  });
  // --------------------
  final SuperVideoController controller;
  final double width;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = SuperVideoScale.getCorners(
      corners: corners,
      width: width,
    );
    // --------------------
    /// THUMBNAIL
    if (controller.youtubeController == null){

      // final double _height = width * 9 / 16;

      return const Stack(
        // children: <Widget>[

          // /// IMAGE
          // SuperImage(
          //   pic: superVideoController.getYouTubeVideoCoverImageURL(),
          //   width: width,
          //   height: _height,
          //   loading: false,
          //   corners: _corners,
          // ),
          //
          // /// PLAY ICON ON TOP
          // SuperBox(
          //   width: width,
          //   height: _height,
          //   icon: Iconz.play,
          //   iconSizeFactor: 0.6,
          //   iconColor: Colors.white,
          //   bubble: false,
          //   opacity: 0.5,
          //   onTap: superVideoController.onVideoTap,
          // ),

        // ],
      );

    }

    /// YOUTUBE PLAYER
    else {
      return _VideoBox(
        width: width,
        boxColor: Colors.black,
        corners: _corners,
        aspectRatio: 16/9,
        child: YoutubePlayer(
          /// MAIN
          key: const ValueKey<String>('YoutubeVideoPlayer'),
          controller: controller.youtubeController!,
          /// SIZING
          width: width,
          // aspectRatio: 16 / 9,
          // actionsPadding: EdgeInsets.all(8.0),

          /// STYLING
          showVideoProgressIndicator: true,
          // bufferIndicator: true,
          liveUIColor: const Color(0xFFff0000),
          // thumbnail: ,

          /// BEHAVIOUR
          // controlsTimeOut: const Duration(seconds: 3),

          /// PROGRESS
          progressIndicatorColor: const Color(0xFFff0000),
          // progressColors: ,

          /// ACTIONS
          // topActions: ,
          // bottomActions: ,

          /// FUNCTIONS
          onReady: () {

            blog('YoutubePlayer is READY');

            if (controller.isAutoPlay == false){
              controller.pause();
            }

            },
          onEnded: (YoutubeMetaData metaData) {
            blog('YoutubePlayer is ENDED : metaData : $metaData');
            },

        ),
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
