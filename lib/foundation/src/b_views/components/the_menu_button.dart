part of app_foundations;

class TheMenuButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheMenuButton({
    required this.text,
    required this.route,
    this.icon,
    super.key
  });
  // --------------------
  final String text;
  final IconData? icon;
  final String route;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? currentLocation = GoRouter.of(context).state.name;
    final bool isSelected = currentLocation == route;
    // --------------------
    return TheButton(
      height: Scale.appBarHeight,
      width: Scale.popUpButtonWidth,
      text: text,
      verseScaleFactor: 0.8,
      // verseWeight: VerseWeight.bold,
      font: 'bebas',
      // verseItalic: true,
      icon: icon,
      // iconColor: iconColor,
      // verseColor: Colorz.white255,
      // iconSizeFactor: bigIcon == true ? 1 : 0.6,
      verseCentered: false,
      // verseMaxLines: 1,
      onTap: () => Routing.goTo(route: route),
      // isDisabled: isDisabled,
      // onDisabledTap: onDisabledTap,
      borderColor: isSelected ? Colorz.black50 : Colorz.white50,
      color: isSelected ? Colorz.black20 : Colorz.white20,
      verseColor: isSelected ? Colorz.black255 : Colorz.white255,
      splashColor: Colorz.black80,
      corners: Borderers.constantCornersAll10,
      // onLongTap: onLongTap,
      // verseHighlight: verseHighlight,
      margins: const EdgeInsets.only(
        left: Scale.popUpButtonSideMargin,
        right: Scale.popUpButtonSideMargin,
        top: 5,
        bottom: 5,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
