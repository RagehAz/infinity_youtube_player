part of app_foundations;

class SuperPopMenu extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperPopMenu({

    required this.popupChild,
    required this.child,
    this.enabled = false,
    this.bubbleColor,
    this.borderColor,
    this.corners = 10,
    this.constraints,
    this.offset = Offset.zero,
    super.key
  });
  // --------------------
  final Color? bubbleColor;
  final Color? borderColor;
  final dynamic corners;
  final BoxConstraints? constraints;
  final Widget popupChild;
  final Widget child;
  final bool enabled;
  final Offset offset;
  // --------------------------------------------------------------------------
  static Future<void> closePopup(BuildContext context) async {
    await Routing.goBack(context: context);
  }
  // --------------------
  static Future<void> show(BuildContext context) async {

    await showDialog(
      context: context,
      builder: (_){
        return Container(
          width: 20,
          height: 30,
          color: Colorz.youtube,
        );
      },
    );

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return _FixedPopupMenuButton(
      enabled: enabled,
      color: bubbleColor,
      shape: RoundedRectangleBorder(
        borderRadius: Borderers.superCorners(corners: corners),
        side: borderColor == null ? BorderSide.none : BorderSide(
          color: borderColor!,
          width: 0.7,
        ),
      ),
      padding: EdgeInsets.zero,
      offset: offset,
      menuPadding: EdgeInsets.zero,
      popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn, duration: const Duration(milliseconds: 300)),
      constraints: constraints ?? BoxConstraints(
        maxWidth: context.screenWidth - 20,
      ),
      elevation: 10,
      position: PopupMenuPosition.over,
      // iconSize: null,
      // splashRadius: 0,
      // tooltip: 'What',
      // useRootNavigator: false,
      // surfaceTintColor: Colorz.red255,
      // position: PopupMenuPosition.over,
      // style: ButtonStyle(
      //   iconSize: WidgetStateProperty.all(0),
      //   fixedSize: WidgetStateProperty.all(Size.zero),
      //   maximumSize: WidgetStateProperty.all(Size.zero),
      //   visualDensity: VisualDensity.compact,
      //
      // ),
      // enableFeedback: false,
      itemBuilder: (_) => [

        _FixedPopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: popupChild,
        ),

      ],
      child: child,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
