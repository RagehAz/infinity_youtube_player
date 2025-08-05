import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';

class VideoScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoScreen({
    super.key
  });
  // --------------------
  @override
  State<VideoScreen> createState() => _VideoScreenState();
  // --------------------------------------------------------------------------
}

class _VideoScreenState extends State<VideoScreen> {
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _loadVideo();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// INITIAL LOADING

  // --------------------
  String? _loadingText = 'loading';
  bool _canBuildVideo = false;
  // --------------------
  void setLoadingText(String? text){
    if (mounted && _loadingText != text){
      setState(() {
        _loadingText = text;
      });
    }
  }
  // --------------------
  Future<void> _loadVideo() async {

    await Future.delayed(const Duration(milliseconds: 500));

    setLoadingText('Fetching User Info ..');

    await Future.delayed(const Duration(milliseconds: 500));

    setLoadingText('Authentication ..');

    await Future.delayed(const Duration(milliseconds: 500));

    setLoadingText('Getting the video ..');

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _loadingText = null;
      _canBuildVideo = true;
    });

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // --------------------

          if (_canBuildVideo == false)
            SuperText(
              boxWidth: context.screenWidth,
              text: _loadingText,
              textHeight: 30,
              margins: 10,
            ),

          // --------------------

          if (_canBuildVideo == true)
          SuperText(
            boxWidth: context.screenWidth,
            text: 'Video title',
            textHeight: 30,
            margins: 10,
          ),

          // --------------------

          /// OLD BASIC PLAYER
          // if (_canBuildVideo == true)
          // TheYoutubePlayer(
          //   canvasWidth: context.screenWidth,
          //   canvasHeight: context.screenWidth * 0.7,
          //   // isMuted: false,
          //   // autoPlay: true,
          //   // loop: false,
          //   url: 'https://youtu.be/46l2HlRQHk8?si=hmnKYWLPKVGRmXqS',
          // ),

          /// NEW PLAYER
          if (_canBuildVideo == true)
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
  // --------------------------------------------------------------------------
}
