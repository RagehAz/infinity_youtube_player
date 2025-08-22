import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_youtube/app/router/routing.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/fonts.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

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
    // blog('currentLocation($currentLocation)');
    // --------------------
    return SuperBox(
      height: Scale.appBarHeight,
      width: Scale.popUpButtonWidth,
      text: text,
      textFont: InfinityFont.montreal,
      textScaleFactor: 0.9,
      // verseItalic: true,
      icon: icon,
      // iconColor: iconColor,
      // verseColor: Colorz.white255,
      // iconSizeFactor: bigIcon == true ? 1 : 0.6,
      textCentered: false,
      // verseMaxLines: 1,
      onTap: () => Routing.goTo(route: route),
      // isDisabled: isDisabled,
      // onDisabledTap: onDisabledTap,
      borderColor: isSelected ? Colorz.majorelleBlueDark3 : Colorz.nothing,
      color: Colorz.white255,
      textColor: Colorz.majorelleBlue,
      splashColor: Colorz.majorelleBlueDark2,
      corners: const BorderRadius.all(Radius.circular(10)),
      // onLongTap: onLongTap,
      // verseHighlight: verseHighlight,
      margins: const EdgeInsets.only(
        left: Scale.popUpButtonSideMargin,
        right: Scale.popUpButtonSideMargin,
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
