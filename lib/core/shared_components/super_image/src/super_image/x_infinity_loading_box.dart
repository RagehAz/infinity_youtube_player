part of super_image;

class InfiniteLoadingBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    required this.width,
    required this.height,
    this.color,
    this.backgroundColor = const Color.fromARGB(50, 255, 255, 255),
    this.milliseconds = 1900,
    super.key
  }); 
  // --------------------
  final double? width;
  final double? height;
  final Color? color;
  final Color backgroundColor;
  final int milliseconds;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? 40;
    final double _height = height ?? _width;

    return Center(
      child: Container(
        width: _width,
        height: _height,
        color: backgroundColor,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
