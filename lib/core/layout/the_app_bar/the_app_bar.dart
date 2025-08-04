import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/core/layout/the_app_bar/the_menu_button.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_image/super_image.dart';
import 'package:infinity_youtube/core/shared_components/super_pop_menu/super_pop_menu.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/iconz.dart';
import 'package:infinity_youtube/core/utilities/scale.dart';

class TheAppBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheAppBar({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _appBarHeight = Scale.appBarHeight;
    // --------------------
    return Container(
      width: _screenWidth,
      height: _appBarHeight,
      decoration: const BoxDecoration(
        color: Colorz.infinityDarkGrey,
        // border: Borderers.borderOnly(
        //   color: Colorz.white125,
        //   bottom: true,
        // ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          SuperBox(
            onTap: () => Routing.goTo(route: Routing.routeHome),
            height: _appBarHeight,
            width: _appBarHeight,
            icon: Iconz.icon,
            iconSizeFactor: 0.7,
            splashColor: Colorz.nothing,
            margins: const EdgeInsets.symmetric(horizontal: 10),
          ),

          const SuperPopMenu(
            corners: BorderRadius.all(Radius.circular(15)),
            borderColor: Colorz.white125,
            // offset: const Offset(0, 0),
            bubbleColor: Colorz.infinityDarkGrey,
            enabled: true,
            popupChild: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                /// HOME
                TheMenuButton(
                  text: 'Home',
                  route: Routing.routeHome,
                ),

                /// HOME
                if (kDebugMode)
                TheMenuButton(
                  text: 'Video (debug)',
                  route: Routing.routeVideo,
                ),

                // --------------------

                /// SPACER
                SizedBox(
                  width: 10,
                  height: 5,
                ),

                /// SPACER
                SizedBox(
                  width: 10,
                  height: 10,
                ),

              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: SuperImage(
                height: Scale.appBarHeight,
                width: Scale.appBarHeight,
                pic: Icons.menu,
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
