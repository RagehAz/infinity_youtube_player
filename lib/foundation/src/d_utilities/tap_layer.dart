part of app_foundations;

enum VibrationType {
  heavy,
  medium,
  light,
  selection,
  vibration,
}

class TapLayer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TapLayer({
    required this.width,
    required this.height,
    this.onTap,
    this.splashColor,
    this.onTapUp,
    this.onTapDown,
    this.onTapCancel,
    this.isDisabled = false,
    this.onDisabledTap,
    this.onLongTap,
    this.onDoubleTap,
    this.corners,
    this.child,
    this.boxColor,
    this.alignment,
    this.margin,
    this.borderColor,
    this.customBorder,
    this.vibrationType = VibrationType.medium,
    super.key
  });
  // --------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final Function? onTapCancel;
  final bool isDisabled;
  final Function? onDisabledTap;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  final ShapeBorder? customBorder;
  final VibrationType vibrationType;
  // --------------------
  static const double borderThickness = 0.75;
  // --------------------
  static BoxBorder? getBorder({
    required Color? color,
  }){
    return color == null ? null : Border.all(
      color: color,
      width: borderThickness,
      strokeAlign: BorderSide.strokeAlignOutside,
    );
  }
  // --------------------
  bool _checkNoTapsGiven(){
    return  onTap == null &&
        onDoubleTap == null &&
        onTapUp == null &&
        onTapDown == null &&
        onLongTap == null;
  }
  // --------------------
  Future<void> _tapWithVibration({
    required Function? onTap,
    VibrationType? type,
  }) async {

    if (onTap != null){

      switch (type ?? vibrationType){
        case VibrationType.heavy: await HapticFeedback.heavyImpact();
        case VibrationType.medium: await HapticFeedback.mediumImpact();
        case VibrationType.light: await HapticFeedback.lightImpact();
        case VibrationType.selection: await HapticFeedback.selectionClick();
        case VibrationType.vibration: await HapticFeedback.vibrate();
      }

      await onTap();

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// NO TAPS
    if (_checkNoTapsGiven() == true){
      return _NoTapsGiven(
        key: key,
        width: width,
        height: height,
        boxColor: boxColor,
        corners: corners,
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: child,
      );
    }

    /// IS DISABLED
    else if (isDisabled == true){

      return _TapStateDisabled(
        width: width,
        height: height,
        onDisabledTap: () => _tapWithVibration(onTap: onDisabledTap, type: VibrationType.light),
        corners: corners,
        boxColor: boxColor,
        alignment: alignment,
        margin: margin,
        borderColor: borderColor,
        child: child,
      );

    }

    /// IS NOT DISABLED
    else {

      /// NO TAP DOWN OR UP
      if (onTapDown == null && onTapUp == null){

        return _TapStateNoUpsAndDowns(
          key: key,
          width: width,
          height: height,
          corners: corners,
          boxColor: boxColor,
          alignment: alignment,
          margin: margin,
          borderColor: borderColor,
          onTap: () => _tapWithVibration(onTap: onTap),
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: () => _tapWithVibration(onTap: onLongTap),
          onDoubleTap: () => _tapWithVibration(onTap: onDoubleTap),
          customBorder: customBorder,
          child: child,
        );

      }

      /// TAP DOWN OR UP
      else {

        return _TapStateWithUpsAndDowns(
          key: key,
          width: width,
          height: height,
          corners: corners,
          boxColor: boxColor,
          alignment: alignment,
          margin: margin,
          borderColor: borderColor,
          onTap: () => _tapWithVibration(onTap: onTap),
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: () => _tapWithVibration(onTap: onLongTap),
          onDoubleTap: () => _tapWithVibration(onTap: onDoubleTap),
          customBorder: customBorder,
          onTapUp: () => _tapWithVibration(onTap: onTapUp),
          onTapDown: () => _tapWithVibration(onTap: onTapDown),
          child: child,
        );

      }

    }

  }
// -----------------------------------------------------------------------------
}

class _NoTapsGiven extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _NoTapsGiven({
    required this.width,
    required this.height,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    super.key
  });
  // --------------------
  final double? width;
  final double? height;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return _TapBox(
      key: const ValueKey<String>('_NoTapsGiven'),
      width: width,
      height: height,
      boxColor: boxColor,
      hasMaterial: false,
      corners: corners ?? BorderRadius.circular(0),
      margin: margin,
      alignment: alignment,
      borderColor: borderColor,
      child: child,
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class _TapStateDisabled extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateDisabled({
    required this.width,
    required this.height,
    required this.onDisabledTap,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Function? onDisabledTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// NO DISABLED TAP
    if (onDisabledTap == null){
      return _TapBox(
        key: const ValueKey<String>('DreamBoxTapLayer_e'),
        width: width,
        height: height,
        boxColor: boxColor,
        hasMaterial: false,
        corners: corners ?? BorderRadius.circular(0),
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: child,
      );
    }
    // --------------------
    /// DISABLED TAP
    else {

      return _TapBox(
        key: const ValueKey<String>('DreamBoxTapLayer_c'),
        width: width,
        height: height,
        boxColor: boxColor,
        hasMaterial: false,
        corners: corners ?? BorderRadius.circular(0),
        margin: margin,
        alignment: alignment,
        borderColor: borderColor,
        child: GestureDetector(
          onTap: () => onDisabledTap!.call(),
          child: child,
        ),
      );
    }
    // --------------------
  }
// --------------------------------------------------------------------------
}

class _TapStateNoUpsAndDowns extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateNoUpsAndDowns({
    required this.width,
    required this.height,
    required this.corners,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    required this.onTap,
    required this.splashColor,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.child,
    required this.customBorder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapCancel;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  final ShapeBorder? customBorder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = corners ?? BorderRadius.circular(0);
    // --------------------
    return _TapBox(
      key: key,
      hasMaterial: true,
      boxColor: boxColor,
      corners: _corners,
      width: width,
      height: height,
      margin: margin,
      alignment: alignment,
      borderColor: borderColor,
      child: Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: _corners,
        child: _TapInkLayer(
          onTap: onTap,
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: onLongTap,
          onDoubleTap: onDoubleTap,
          corners: corners,
          customBorder: customBorder,
          child: child,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class _TapStateWithUpsAndDowns extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapStateWithUpsAndDowns({
    required this.width,
    required this.height,
    required this.onTap,
    required this.splashColor,
    required this.onTapUp,
    required this.onTapDown,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.corners,
    required this.child,
    required this.boxColor,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    required this.customBorder,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final double? height;
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapUp;
  final Function? onTapDown;
  final Function? onTapCancel;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Color? boxColor;
  final Widget? child;
  final EdgeInsets? margin;
  final Alignment? alignment;
  final Color? borderColor;
  final ShapeBorder? customBorder;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _corners = corners ?? BorderRadius.circular(0);
    // --------------------
    return _TapBox(
      key: key,
      hasMaterial: true,
      width: width,
      height: height,
      corners: _corners,
      boxColor: boxColor,
      margin: margin,
      alignment: alignment,
      borderColor: borderColor,
      child: GestureDetector(
        // onLongPress: onLongTap,
        onTapDown: onTapDown == null ? null : (TapDownDetails details) => onTapDown?.call(),
        onTapUp: onTapUp == null ? null : (TapUpDetails details) => onTapUp?.call(),
        child: _TapInkLayer(
          onTap: onTap,
          splashColor: splashColor,
          onTapCancel: onTapCancel,
          onLongTap: onLongTap,
          onDoubleTap: onDoubleTap,
          corners: corners,
          customBorder: customBorder,
          child: child,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class _TapBox extends StatelessWidget {

  const _TapBox({
    required this.width,
    required this.height,
    required this.corners,
    required this.boxColor,
    required this.hasMaterial,
    required this.alignment,
    required this.margin,
    required this.borderColor,
    this.child,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius corners;
  final Widget? child;
  final Color? boxColor;
  final bool hasMaterial;
  final Alignment? alignment;
  final EdgeInsets? margin;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {

    // final double _borderFactor = borderColor == null ? 0 : (_borderThickness*2);
    final double? _width = width == null ? null : width! - 0;
    final double? _height = height == null ? null : height! - 0;

    return Container(
      key: const ValueKey<String>('_TapBox_b'),
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: corners,
        color: boxColor,
        border: TapLayer.getBorder(
          color: borderColor,
        ),
      ),
      alignment: alignment,
      margin: margin,
      child: hasMaterial == false ? child : Material(
        color: const Color.fromARGB(0, 255, 255, 255),
        borderRadius: corners,
        child: child,
      ),
    );

  }

}

class _TapInkLayer extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _TapInkLayer({
    required this.onTap,
    required this.splashColor,
    required this.onTapCancel,
    required this.onLongTap,
    required this.onDoubleTap,
    required this.corners,
    required this.child,
    required this.customBorder,
  });
  /// --------------------------------------------------------------------------
  final Color? splashColor;
  final Function? onTap;
  final Function? onTapCancel;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final BorderRadius? corners;
  final Widget? child;
  final ShapeBorder? customBorder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (splashColor == null || splashColor == Colorz.nothing){
      return GestureDetector(
        key: key,
        onTap: onTap == null ? null : () => onTap!.call(),
        onTapCancel: onTapCancel == null ? null : () => onTapCancel!(),
        onLongPress: onLongTap == null ? null : () => onLongTap!(),
        onDoubleTap: onDoubleTap == null ? null : () => onDoubleTap!(),
        child: child,
      );
    }
    // --------------------
    else {

      final BorderRadius _corners = corners ?? BorderRadius.circular(0);

      return InkWell(
        key: key,
        splashColor: onTap == null ? Colorz.nothing : splashColor,
        highlightColor: onTap == null ? Colorz.nothing :Colorz.black20,
        onTap: onTap == null ? null : () => onTap!.call(),
        onTapCancel: onTapCancel == null ? null : () => onTapCancel!(),
        onLongPress: onLongTap == null ? null : () => onLongTap!(),
        onDoubleTap: onDoubleTap == null ? null : () => onDoubleTap!(),
        borderRadius: _corners,
        // hoverColor: Colorz.white10,
        customBorder: customBorder,
        // overlayColor: ,
        // highlightColor: ,
        // key: ,
        // autofocus: ,
        // canRequestFocus: ,
        // enableFeedback: ,
        // excludeFromSemantics: ,
        // focusColor: ,
        // focusNode: ,
        // mouseCursor: ,
        // onFocusChange: ,
        // onHighlightChanged: ,
        // onHover: ,
        // onSecondaryTap: ,
        // onSecondaryTapCancel: ,
        // onSecondaryTapDown: ,
        // onSecondaryTapUp: ,
        // onTapDown: ,
        // onTapUp: ,
        // radius: ,
        // splashFactory: ,
        // statesController: ,
        child: child,
      );
    }
    // --------------------
  }
// --------------------------------------------------------------------------
}
