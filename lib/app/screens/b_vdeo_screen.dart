import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/services/audio_source_analyzer.dart';
import 'package:infinity_youtube/core/services/audio_source_model.dart';
import 'package:infinity_youtube/core/services/video_source_analyzer.dart';
import 'package:infinity_youtube/core/services/video_source_model.dart';
import 'package:infinity_youtube/core/services/youtube.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
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
  final YoutubeParser parser = YoutubeParser();
  String? _videoYoutubeURL;
  List<VideoSourceModel> _videoSources = <VideoSourceModel>[];
  VideoSourceModel? _selectedVideoSource;
  AudioSourceModel? _selectedAudioSource;
  // --------------------------------------------------------------------------
  @override
  void initState() {

    _videoYoutubeURL = 'https://youtu.be/46l2HlRQHk8?si=hmnKYWLPKVGRmXqS';

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
    parser.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// INITIAL LOADING

  // --------------------
  String? _loadingText = 'loading';
  bool _canBuildVideo = false;
  // --------------------
  /// TESTED : WORKS PERFECT
  void setLoadingText(String? text){
    if (mounted && _loadingText != text){
      setState(() {
        _loadingText = text;
      });
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadVideo() async {

    blog('_loadVideo(Start)');

    if (_videoYoutubeURL != null){

      setLoadingText('Reading video info ..');

      final YouTubeSource _youtubeSource = await parser.parse(_videoYoutubeURL!);

      if (mounted == true){

        setState(() {

          /// ALL VIDEO SOURCES
          _videoSources = VideoSourceAnalyzer.getSmallestVideoOfEachQuality(
            videoSources: _youtubeSource.video,
          );

          /// SELECTED
          _selectedAudioSource = AudioSourceAnalyzer.getSmallestAudio(
            audioSources: _youtubeSource.audio,
          );
          _selectedVideoSource = _videoSources.last;

          /// BUILD
          _loadingText = null;
          _canBuildVideo = true;

        });

      }

    }

    blog('_loadVideo(End)');

  }
  // --------------------------------------------------------------------------

  /// BOTTOM SHEET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> showTheBottomSheet({
    required List<Widget> tiles,
  }) async {

    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),

        ),
      ),
      backgroundColor: Colorz.infinityDarkGrey,
      builder: (context) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: tiles,
        );

      },
    );
  }
  // --------------------------------------------------------------------------

  /// PICk QUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _pickQuality() async {

    await showTheBottomSheet(
      tiles: <Widget>[

        ...List.generate(_videoSources.length, (int index){

          final VideoSourceModel _source = _videoSources[index];

          return _qualityTile(
              text: _source.quality,
              isSelected: _selectedVideoSource?.quality == _source.quality,
              onTap: () async {
                if (mounted){
                  _selectedVideoSource = _source;
                }
                await Routing.goBack(context: context);
              },
          );

        }),

        const SizedBox(
          width: 40,
          height: 40,
        ),

      ],
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _qualityTile({
    required Function onTap,
    required String text,
    required bool isSelected,
    dynamic icon,
  }) {
    return SuperBox(
      height: 60,
      width: context.screenWidth - 10,
      color: isSelected ? Colorz.white50 : Colorz.white20,
      borderColor: isSelected ? Colorz.white125 : null,
      margins: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 5,
      ),
      icon: icon,
      textColor: Colorz.black255,
      text: text,
      // appIsLTR: true,
      // textDirection: TextDirection.ltr,
      textCentered: false,
      onTap: () => onTap(),
    );
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
            Container(
              width: context.screenWidth,
              height: context.screenWidth * 0.7,
              color: Colorz.black255,
            ),

          /// DEBUG CONTROL BAR
          Builder(
            builder: (context) {

              const double barHeight = 70;
              const double buttonSize = 50;

              return Container(
                width: context.screenWidth,
                height: barHeight,
                color: Colorz.black255,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[

                      const SizedBox(width: 5, height: 5),

                      _TestButton(
                        size: buttonSize,
                        text: 'Load Video source',
                        icon: Icons.cloud_download_outlined,
                        onTap: _loadVideo,
                      ),

                      _TestButton(
                        size: buttonSize,
                        text: 'Quality',
                        icon: Icons.keyboard_capslock_outlined,
                        onTap: _pickQuality,
                      ),

                    ],
                  ),
                ),
              );
            }
          ),

          // --------------------

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class _TestButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TestButton({
    required this.text,
    required this.icon,
    required this.onTap,
    required this.size,
  });
  // --------------------
  final String text;
  final dynamic icon;
  final Function onTap;
  final double size;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      height: size,
      text: text,
      icon: icon,
      iconSizeFactor: 0.7,
      color: Colorz.white20,
      onTap: onTap,
      margins: const EdgeInsets.symmetric(horizontal: 5),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
