part of app_foundations;

class VerticalFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VerticalFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.padding = EdgeInsets.zero,
    this.boxAlignment = Alignment.center,
    this.width,
    this.height,
    this.physics = const BouncingScrollPhysics(),
    this.boxCorners,
    this.boxColor,
    this.scrollController,
    this.borderColor,
    super.key
  });
  // --------------------
  final List<Widget>? columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  final ScrollPhysics physics;
  final Alignment? boxAlignment;
  final dynamic boxCorners;
  final Color? boxColor;
  final ScrollController? scrollController;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ScrollConfiguration(
      behavior: const AppScrollBehavior(),
      child: SingleChildScrollView(
        physics: physics,
        controller: scrollController,
        child: Container(
          width: width ?? Scale.screenWidth(context),
          constraints: BoxConstraints(
            minHeight: height ?? Scale.screenHeight(context),
          ),
          decoration: BoxDecoration(
              color: boxColor,
              borderRadius: Borderers.superCorners(corners: boxCorners),
              border: borderColor == null ? null :
              Border.all(
                width: 0.5,
                color: borderColor!,
                strokeAlign: BorderSide.strokeAlignOutside,
              )
          ),
          alignment: boxAlignment,
          padding: padding,
          child: Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: <Widget>[
              ...?columnChildren,
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
