part of super_image;

class SuperImageBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImageBox({
    required this.child,
    required this.width,
    required this.height,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    this.solidGreyScale = false,
    this.borderColor,
    super.key,
  }); 
  /// --------------------------------------------------------------------------
  final double? width;
  final double height;
  final BoxFit boxFit;
  final double? scale;
  final Color? backgroundColor;
  final dynamic corners;
  final bool greyscale;
  final Widget? child;
  final bool solidGreyScale;
  final Color? borderColor;
  /// --------------------------------------------------------------------------
  static ColorFilter getGreyScaleFilter({
    required bool solidGrey,
  }){

    if (solidGrey == true){
      return const ColorFilter.mode(Color.fromARGB(50, 255, 255, 255), BlendMode.srcIn);
    }
    else {
      return const ColorFilter.mode(Color.fromARGB(200, 255, 255, 255), BlendMode.color);
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius _superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = _cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius _cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BoxBorder? _border = borderColor == null ? null : Border.all(
      color: borderColor!,
      // width: 1,
    );

    final BorderRadius _corners = _superCorners(
      corners: corners,
    );

    if (greyscale == true){
      return ClipRRect(
        key: const ValueKey<String>('SuperImageBox1'),
        borderRadius: _corners,
        child: ColorFiltered(
          colorFilter: getGreyScaleFilter(solidGrey: solidGreyScale),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: _border,
              borderRadius: _corners,
              // boxShadow: <BoxShadow>[
              //   Shadowz.CustomBoxShadow(
              //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
              //       offset: Offset(0, width * -0.019),
              //       blurRadius: width * 0.2,
              //       style: BlurStyle.outer
              //   ),
              // ]
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        ),
      );
    }

    else if (corners == null || corners == EdgeInsets.zero || corners == 0){
      return Container(
        key: const ValueKey<String>('SuperImageBox2'),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: _border,
          borderRadius: _corners,
          // boxShadow: <BoxShadow>[
          //   Shadowz.CustomBoxShadow(
          //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
          //       offset: Offset(0, width * -0.019),
          //       blurRadius: width * 0.2,
          //       style: BlurStyle.outer
          //   ),
          // ]
        ),
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale,
          child: child,
        ),
      );
    }
    
    else {
      return Container(
        key: const ValueKey<String>('SuperImageBox3'),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: _border,
          borderRadius: _corners,
            // boxShadow: <BoxShadow>[
            //   Shadowz.CustomBoxShadow(
            //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
            //       offset: Offset(0, width * -0.019),
            //       blurRadius: width * 0.2,
            //       style: BlurStyle.outer
            //   ),
            // ]
          ),
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale,
          child: ClipRRect(
            borderRadius: _corners,
            child: child,
          ),
        ),
      );
    }

  }
  /// --------------------------------------------------------------------------
}
