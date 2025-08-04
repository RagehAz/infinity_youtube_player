import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_button.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
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
    blog('currentLocation($currentLocation)');
    // --------------------
    return TheButton(
      height: Scale.appBarHeight,
      width: Scale.popUpButtonWidth,
      text: text,
      verseScaleFactor: 0.8,
      // verseWeight: VerseWeight.bold,
      font: '',
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
      borderColor: isSelected ? Colorz.white50 : Colorz.nothing,
      color: isSelected ? Colorz.white20 : Colorz.white20,
      verseColor: isSelected ? Colorz.white255 : Colorz.white255,
      splashColor: Colorz.black80,
      corners: const BorderRadius.all(Radius.circular(10)),
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
