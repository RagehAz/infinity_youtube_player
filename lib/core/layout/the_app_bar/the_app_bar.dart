import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/c_routing.dart';
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

          TapLayer(
            width: 200,
            height: _appBarHeight,
            onTap: () => Routing.goTo(route: Routing.routeHome),
            splashColor: Colorz.nothing,
            child: const SuperImage(
              loading: false,
              height: _appBarHeight,
              width: 200,
              pic: Iconz.logo,
              scale: 0.8,
            ),
          ),

          const SuperPopMenu(
            corners: BorderRadius.all(Radius.circular(15)),
            borderColor: Colorz.white125,
            // offset: const Offset(0, 0),
            bubbleColor: Colorz.black255,
            enabled: true,
            popupChild: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [


                /// HOME
                TheMenuButton(
                  text: 'Home',
                  route: Routing.routeHome,
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
              child: SizedBox(
                height: Scale.appBarHeight,
                width: Scale.appBarHeight,
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
