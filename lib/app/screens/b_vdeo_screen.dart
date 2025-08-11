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
import 'package:infinity_youtube/core/theme/fonts.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoScreen({super.key});
  // --------------------
  @override
  State<VideoScreen> createState() => _VideoScreenState();
  // --------------------------------------------------------------------------
}

class _VideoScreenState extends State<VideoScreen> {
  // --------------------------------------------------------------------------
  static const String _youtubeURL =
      'https://youtu.be/MbAs4s_S0rc?si=lc5Rrj6kmOF6mJc1';
  // --------------------------------------------------------------------------
  final YoutubeParser parser = YoutubeParser();
  String? _videoYoutubeURL;
  List<VideoSourceModel> _videoSources = <VideoSourceModel>[];
  VideoSourceModel? _selectedVideoSource;
  AudioSourceModel? _selectedAudioSource;
  late Player player;
  late VideoController controller;
  Duration? currentPosition;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    _videoYoutubeURL = _youtubeURL;

    player = Player();

    controller = VideoController(player);

    player.stream.position.listen(
      (Duration position) => currentPosition = position,
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
  void setLoadingText(String? text) {
    if (mounted && _loadingText != text) {
      setState(() {
        _loadingText = text;
      });
    }
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadVideo() async {
    blog('_loadVideo(Start)');

    if (_videoYoutubeURL != null) {
      setLoadingText('Reading video info ..');

      final YouTubeSource _youtubeSource = await parser.parse(
        _videoYoutubeURL!,
      );

      if (mounted == true) {
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
    if (_selectedVideoSource != null) {
      final position = currentPosition;
      final Media _media = Media(_selectedVideoSource!.video);

      await player.open(_media, play: false);

      await player.play();
      while (!player.state.playing || player.state.buffering) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (_selectedAudioSource != null) {
        await player.setAudioTrack(AudioTrack.uri(_selectedAudioSource!.audio));
      }

      if (position != null) {
        await player.seek(position);
      }
    }
  }

  /// BOTTOM SHEET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> showTheBottomSheet({required List<Widget> tiles}) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (context) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: tiles,
            ),
          ),
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
        ...List.generate(_videoSources.length, (int index) {
          final VideoSourceModel _source = _videoSources[index];

          return _qualityTile(
            source: _source,
            onTap: () async {
              blog('wiping');

              if (mounted) {
                setState(() {
                  _canBuildVideo = false;
                  _selectedVideoSource = null;
                });
              }

              await Routing.goBack(context: context);

              if (mounted) {
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
      ],
    );
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  Widget _qualityTile({
    required void Function() onTap,
    required VideoSourceModel source,
  }) {
    return RadioListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(
        source.quality,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${source.size.totalMegaBytes.toStringAsFixed(2)} MB',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      value: source,
      groupValue: _selectedVideoSource,
      onChanged: (value) {
        onTap();
      },
    );
  }

  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final controls = MaterialVideoControlsThemeData(
      volumeGesture: true,
      brightnessGesture: true,
      topButtonBar: [
        SuperBox(
          height: 35,
          icon: Icons.settings,
          iconSizeFactor: 0.7,
          color: Colorz.white20,
          onTap: _pickQuality,
          margins: const EdgeInsets.symmetric(horizontal: 5),
        ),
      ],
    );
    // --------------------
    return TheLayout(
      backgroundColor: Colorz.black255,
      child: SingleChildScrollView(
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
                font: InfinityFont.regular,
              ),
            // --------------------
            if (_canBuildVideo == true)
              SuperText(
                boxWidth: context.screenWidth,
                text: '<Video Title>',
                textHeight: 30,
                margins: 10,
                font: InfinityFont.regular,
              ),
            // --------------------
            /// NEW PLAYER
            if (_canBuildVideo == true)
              MaterialVideoControlsTheme(
                normal: controls,
                fullscreen: controls,
                child: Container(
                  width: context.screenWidth,
                  height: context.screenWidth * 9.0 / 16.0,
                  color: Colorz.googleRed,
                  child: Video(
                    controller: controller,
                    controls: (state) => MaterialVideoControls(state),
                  ),
                ),
              ),
            // --------------------
          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
