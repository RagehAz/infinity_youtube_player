part of the_youtube_player;

class _VideoBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _VideoBox({
    required this.width,
    required this.child,
    required this.boxColor,
    required this.aspectRatio,
    required this.corners,
  });
  // --------------------------------------------------------------------------
  final double width;
  final Widget? child;
  final Color boxColor;
  final double? aspectRatio;
  final dynamic corners;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = SuperVideoScale.getHeightByAspectRatio(
      aspectRatio: aspectRatio,
      width: width,
      force169: false,
    );

    final BorderRadius _corners = SuperVideoScale.getCorners(
      corners: corners,
      width: width,
    );

    return Container(
      width: width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: _corners,
        color: boxColor,
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: _corners,
        child: child,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
