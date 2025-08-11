import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_menu_button.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_image/super_image.dart';
import 'package:infinity_youtube/core/shared_components/super_pop_menu/super_pop_menu.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/iconz.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget {
  // --------------------------------------------------------------------------
  const TheAppBar({super.key});
  // -----------------------------------------------------------------------------

  @override
  Size get preferredSize => const Size.fromHeight(Scale.appBarHeight);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _appBarHeight = Scale.appBarHeight;
    final topMargin = context.safeAreaTopPadding;
    // --------------------
    return Container(
      width: _screenWidth,
      height: _appBarHeight + topMargin,
      padding: EdgeInsets.only(top: topMargin),
      decoration: const BoxDecoration(
        color: Colorz.white255,
        // border: Borderers.borderOnly(
        //   color: Colorz.white125,
        //   bottom: true,
        // ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SuperBox(
            onTap: () => Routing.goTo(route: Routing.routeHome),
            height: _appBarHeight,
            width: _appBarHeight,
            icon: Iconz.iconColored,
            iconSizeFactor: 0.7,
            splashColor: Colorz.nothing,
            margins: const EdgeInsets.symmetric(horizontal: 10),
          ),

          const SuperPopMenu(
            corners: BorderRadius.all(Radius.circular(15)),
            borderColor: Colorz.majorelleBlueDark3,
            // offset: const Offset(0, 0),
            bubbleColor: Colorz.majorelleBlue,
            enabled: true,
            popupChild: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                /// SPACING
                SizedBox(width: 10, height: 10),

                /// HOME
                TheMenuButton(text: 'HOME', route: Routing.routeHome),

                /// SPACING
                SizedBox(width: 10, height: 10),

                /// For Demo
                TheMenuButton(text: 'VIDEO (Demo)', route: Routing.routeVideo),

                /// SPACING
                SizedBox(width: 10, height: 10),

              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SuperImage(
                height: Scale.appBarHeight,
                width: Scale.appBarHeight,
                pic: Iconz.palette,
                iconColor: Colorz.majorelleBlue,
                loading: false,
                scale: 0.6,
              ),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }

  // -----------------------------------------------------------------------------
}
