part of the_youtube_player;

class SuperVideoController {
  // --------------------
  VoidCallback? refresh;
  // --------------------
  Wire<bool> mounted = Wire<bool>(true);
  // --------------------
  YoutubePlayerController? _youtubeController;
  YoutubePlayerController? get youtubeController => _youtubeController;
  // --------------------
  final Wire<double> _volume = Wire<double>(1);
  Wire<double> get volume => _volume;
  // --------------------
  double _volumeBeforeMute = 1;
  double get volumeBeforeMute => _volumeBeforeMute;
  // --------------------
  String? _videoURL;
  String? get videoURL => _videoURL;
  // --------------------
  bool _isYoutubeURL = false;
  bool get isYoutubeURL => _isYoutubeURL;
  // --------------------
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  // --------------------
  bool _isAutoPlay = false;
  bool get isAutoPlay => _isAutoPlay;
  // --------------------
  bool _canBuild = false;
  bool get canBuild => _canBuild;
  // --------------------------------------------------------------------------
  /// --- LOADING
  final Wire<bool> loading = Wire(false);
  // --------------------
  void _triggerLoading({required bool setTo}) {
    setNotifier(
      notifier: loading,
      mounted: mounted.value,
      value: setTo,
    );
  }
  // --------------------------------------------------------------------------

  /// STARTERS

  // --------------------
  ///
  void init({
    required VoidCallback onSetState,
  }){
    mounted.set(value: true);
    refresh = onSetState;
  }
  // --------------------
  ///
  bool _isInit = true;
  void didChangeDependencies({
    required String? url,
    bool autoPlay = true,
    bool loop = false,
    bool isMuted = false,
  }){
    if (_isInit && mounted.value) {
      _isInit = false;
      asyncInSync(() => loadYoutubeURL(
        url: url,
        autoPlay: autoPlay,
        isMuted: isMuted,
        loop: loop,
      ));
    }
  }
  // --------------------
  ///
  void onDidUpdateWidget({

    required dynamic oldVideo,
    required dynamic newVideo,

    required bool oldAutoPlay,
    required bool newAutoPlay,

    required bool oldLoop,
    required bool newLoop,

    required bool oldIsMuted,
    required bool newIsMuted,

    required double newCanvasWidth,
    required double oldCanvasWidth,

    required double newCanvasHeight,
    required double oldCanvasHeight,

    required dynamic newCanvasCorners,
    required dynamic oldCanvasCorners,

    // required dynamic newCover,
    // required dynamic oldCover,

  }){

    asyncInSync(() async {

      if (oldVideo != newVideo) {
        _isInit = true;
        didChangeDependencies(
          url: newVideo,
          autoPlay: newAutoPlay,
          loop: newLoop,
          isMuted: newIsMuted,
        );
      }

      else if (oldIsMuted != newIsMuted){
        await onMutingTap();
      }

      else if (oldLoop != newLoop){
        await setLooping(newLoop);
      }

      else if (oldAutoPlay != newAutoPlay){
        if (newAutoPlay == true){
          await setLooping(true);
          await play();
        }
        else {
          await setLooping(false);
          await pause();
        }
      }

      else if (
          oldCanvasWidth != newCanvasWidth ||
          oldCanvasHeight != newCanvasHeight ||
          oldCanvasCorners != newCanvasCorners
          // ||
          // oldCover != newCover ||
      ){
        if (mounted.value == true){
          refresh!();
        }
      }

    });

  }
  // --------------------
  ///
  void dispose(){
    if (mounted.value == true){
      mounted.set(value: false, mounted: true);
      _youtubeController?.dispose();
      loading.dispose();
      _volume.dispose();
      mounted.dispose();
    }
  }
  // --------------------------------------------------------------------------

  /// LOADING

  // --------------------
  ///
  Future<void> loadYoutubeURL({
    required String? url,
    required bool autoPlay,
    required bool loop,
    required bool isMuted,
  }) async {

    final bool _isYoutubeLink = SuperVideoCheckers.checkIsValidYoutubeLink(url);

    /// YOUTUBE URL
    if (_isYoutubeLink == true){
      _triggerLoading(setTo: true);

      final String? _videoID = SuperYoutubeMethods.extractVideoIDFromYoutubeURL(url);

      final bool _isValidVideoID = SuperYoutubeMethods.checkIsValidYoutubeVideoID(_videoID);

      if (_videoID != null && _isValidVideoID == true){

        _youtubeController = YoutubePlayerController(
          initialVideoId: _videoID,
          flags: YoutubePlayerFlags(
            /// AUTO PLAY
            autoPlay: autoPlay,
            /// LOOPING
            loop: loop,
            /// VOLUME
            mute: isMuted,
            /// CAPTION
            // captionLanguage: ,
            // enableCaption: ,
            /// START - END
            // startAt: ,
            // endAt: ,
            /// QUALITY
            // forceHD: ,
            /// CONTROLS
            // hideControls: false,
            // controlsVisibleAtStart: ,
            // disableDragSeek: ,
            // showLiveFullscreenButton: ,
            /// TYPE
            // isLive: ,
            // useHybridComposition: ,
            /// THUMBNAIL
            // hideThumbnail: ,
          ),
        );

        _setupYoutubePlayer(
          autoPlay: autoPlay,
          isMuted: isMuted,
        );

        _canBuild = true;

      }

      _isYoutubeURL = true;
      _videoURL = url;

      refresh?.call();

      _triggerLoading(setTo: true);
    }

    /// VIDEO URL
    else {
      /// NOT YOU TUBE URL
    }

  }
  // --------------------
  ///
  void _setupYoutubePlayer({
    required bool autoPlay,
    required bool isMuted,
  }){

    /// VOLUME
    _youtubeController?.setVolume(isMuted ? 0 : 100);

    /// AUTO PLAY
    if (autoPlay == true){
      play();
    }
    else {
      pause();
    }

    /// IS AUTO PLAY
    _isAutoPlay = autoPlay;

  }
  // --------------------------------------------------------------------------

  /// PLAYING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onVideoTap() async {

    if (_isPlaying == true){
      await pause();
    }
    else {
      await play();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> play() async {
    if (_isPlaying == false){
      _isPlaying = true;
      _youtubeController?.play();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> pause() async {
    if (_isPlaying == true){
      _isPlaying = false;
      _youtubeController?.pause();
    }
  }

  Future<void> setVolume(double volume) async {

    if (_volume.value != volume){

      _youtubeController?.setVolume((volume * 100).toInt());

      _volume.set(
          mounted: mounted.value,
          value: volume
      );

    }

  }
  // --------------------------------------------------------------------------

  /// MUTING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onMutingTap() async {

    final bool _isMuted = checkIsMuted();

    if (_isMuted){
      await unMute();
    }

    else {
      await mute();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> mute() async {
    _volumeBeforeMute = _volume.value;
    await setVolume(0);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> unMute() async {
    await setVolume(_volumeBeforeMute);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool checkIsMuted(){
    return _volume.value == 0;
  }
  // --------------------------------------------------------------------------

  /// LOOPING

  // --------------------
  Future<void> setLooping(bool setTo) async {

    if (setTo == true){
      // await _videoPlayerController?.setLooping(true);
      await play();
    }

    else {
      // await _videoPlayerController?.setLooping(false);
      await pause();
    }

  }
  // --------------------------------------------------------------------------
  // --------------------------------------------------------------------------
  void x(){}
  // --------------------------------------------------------------------------
}
