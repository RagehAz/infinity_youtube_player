part of the_youtube_player;

class TheYoutubePlayer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const TheYoutubePlayer({
    required this.canvasWidth,
    required this.canvasHeight,
    required this.url,
    this.corners,
    this.isMuted = false,
    this.autoPlay = true,
    this.loop = false,
    super.key
  });
  // --------------------
  final String? url;
  final double canvasWidth;
  final double canvasHeight;
  final dynamic corners;
  final bool isMuted;
  final bool autoPlay;
  final bool loop;
  // --------------------
  @override
  State<TheYoutubePlayer> createState() => _TheYoutubePlayerState();
  // --------------------------------------------------------------------------
}

class _TheYoutubePlayerState extends State<TheYoutubePlayer> {
  // --------------------------------------------------------------------------
  final SuperVideoController controller = SuperVideoController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    controller.init(
      onSetState: () => setState((){}),
    );
  }
  // --------------------
  @override
  void didChangeDependencies() {

    controller.didChangeDependencies(
      url: widget.url,
      autoPlay: widget.autoPlay,
      loop: widget.loop,
      isMuted: widget.isMuted,
    );

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(TheYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.onDidUpdateWidget(
      oldVideo: oldWidget.url,
      newVideo: widget.url,

      oldAutoPlay: oldWidget.autoPlay,
      newAutoPlay: widget.autoPlay,

      oldLoop: oldWidget.loop,
      newLoop: widget.loop,

      oldIsMuted: oldWidget.isMuted,
      newIsMuted: widget.isMuted,

      oldCanvasWidth: oldWidget.canvasWidth,
      newCanvasWidth: widget.canvasWidth,

      oldCanvasHeight: oldWidget.canvasHeight,
      newCanvasHeight: widget.canvasHeight,

      oldCanvasCorners: oldWidget.corners,
      newCanvasCorners: widget.corners,

    );
  }
  // --------------------
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (controller.canBuild == true){
        return _Player(
          controller: controller,
          width: widget.canvasWidth,
          corners: widget.corners,
        );
    }
    // --------------------
    else {
      return _VideoBox(
        width: widget.canvasWidth,
        aspectRatio: widget.canvasWidth / widget.canvasHeight,
        corners: widget.corners,
        boxColor: Colors.black,
        child: null,
      );
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
