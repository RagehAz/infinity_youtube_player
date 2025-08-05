import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/services/video_source_analyzer.dart';
import 'package:infinity_youtube/core/services/video_source_model.dart';
import 'package:infinity_youtube/core/services/youtube.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

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
  static const String _testURL = 'https://d2jraqneynooaz.cloudfront.net/bzz/HLwWnNrTnKcCCDgWW3i9/flyers/xaplnFKfA7LAJDf0CiZk/0_video';
  static const String _youtubeURL = 'https://youtu.be/46l2HlRQHk8?si=hmnKYWLPKVGRmXqS';
  // --------------------------------------------------------------------------
  final YoutubeParser parser = YoutubeParser();
  String? _videoYoutubeURL;
  List<VideoSourceModel> _videoSources = <VideoSourceModel>[];
  VideoSourceModel? _selectedVideoSource;
  // AudioSourceModel? _selectedAudioSource;
  late Player player;
  late VideoController controller = VideoController(player);
  // --------------------------------------------------------------------------
  @override
  void initState() {

    _videoYoutubeURL = _youtubeURL;

    player = Player(
      configuration: PlayerConfiguration(
        vo: 'opengl', // or 'opengl', or 'x11' depending on the platform
        // vo: ,
        // title: ,
        // async: ,
        // bufferSize: ,
        // libass: ,
        // libassAndroidFont: ,
        // libassAndroidFontName: ,
        // logLevel: ,
        // muted: ,
        // osc: ,
        // pitch: ,
        // protocolWhitelist: ,
        // ready: ,
      ),
    );

    controller = VideoController(
      player,
      configuration: VideoControllerConfiguration(
        width: 100,
        height: (100 * 9.0 / 16.0).toInt(),
        // androidAttachSurfaceAfterVideoParameters: ,
        // enableHardwareAcceleration: true,
        hwdec: 'auto',
        // scale: ,
        // vo: ,
      ),
    );

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
    player.dispose();
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
          // _selectedAudioSource = AudioSourceAnalyzer.getSmallestAudio(
          //   audioSources: _youtubeSource.audio,
          // );
          _selectedVideoSource = _videoSources.last;

          /// BUILD
          _loadingText = null;
          _canBuildVideo = true;

        });

        await _startPlayer();

      }

    }

    blog('_loadVideo(End)');

  }
  // --------------------------------------------------------------------------

  /// VIDEO PLAYING

  // --------------------
  ///
  Future<void> _startPlayer() async {

    if (_selectedVideoSource != null){

      final Media _media = Media(_selectedVideoSource!.video);

      await player.open(
        _media,
        // play: true,
      );

      // await player.play();

    }

  }
  // --------------------
  ///
  Future<void> _requestAccess() async {
    /*
    if (/* Android 13 or higher. */) {
      // Video permissions.
      if (await Permission.videos.isDenied || await Permission.videos.isPermanentlyDenied) {
        final state = await Permission.videos.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
      // Audio permissions.
      if (await Permission.audio.isDenied || await Permission.audio.isPermanentlyDenied) {
        final state = await Permission.audio.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
    } else {
      if (await Permission.storage.isDenied || await Permission.storage.isPermanentlyDenied) {
        final state = await Permission.storage.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
    }
     */
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

          final String _mbs = _source.size.totalMegaBytes.toStringAsFixed(2);

          return _qualityTile(
              text: '${_source.quality} . $_mbs Mb',
              isSelected: _selectedVideoSource?.quality == _source.quality,
              onTap: () async {

                blog('wiping');

                if (mounted){
                  setState(() {
                    _canBuildVideo = false;
                    _selectedVideoSource = null;
                  });
                }

                await Routing.goBack(context: context);

                if (mounted){
                  setState(() {
                    _canBuildVideo = true;
                    _selectedVideoSource = _source;
                  });
                }

                await _startPlayer();

                blog('starting');

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
            text: 'youtube player',
            textHeight: 30,
            margins: 10,
          ),

          // --------------------

          /// OLD BASIC PLAYER
          if (_canBuildVideo == true)
          TheYoutubePlayer(
            canvasWidth: context.screenWidth,
            canvasHeight: context.screenWidth * 0.7,
            // isMuted: false,
            // autoPlay: true,
            // loop: false,
            url: _videoYoutubeURL,
          ),

          if (_canBuildVideo == true)
            SuperText(
              boxWidth: context.screenWidth,
              text: 'Media kit',
              textHeight: 30,
              margins: 10,
            ),

          /// NEW PLAYER
          if (_canBuildVideo == true)
            Container(
              width: context.screenWidth,
              height: context.screenWidth * 9.0 / 16.0,
              color: Colorz.googleRed,
              child: Video(
                controller: controller,
                width: context.screenWidth,
                height: context.screenWidth * 9.0 / 16.0,
                // fit: BoxFit.contain,
                // fill: Colorz.nothing,
                // alignment: Alignment.center,
              ),
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

                      _TestButton(
                        size: buttonSize,
                        text: 'Play',
                        icon: Icons.play_arrow,
                        onTap: () => player.play(),
                      ),

                      _TestButton(
                        size: buttonSize,
                        text: 'Pause',
                        icon: Icons.pause,
                        onTap: () async {

                          if (mounted){
                            await player.pause();
                            setState(() {});
                          }

                        },
                      ),

                      _TestButton(
                        size: buttonSize,
                        text: 'Print Sources',
                        icon: Icons.print,
                        onTap: () async {

                          final List<String> _unique = [];

                          blog('start');
                          for (final VideoSourceModel source in _videoSources){
                            blog(source);

                            if (_unique.contains(source.video) == false){
                              _unique.add(source.video);
                            }

                          }
                          blog('done -----------------------');

                          blog('_unique links (${_unique.length}) links');

                        },
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
