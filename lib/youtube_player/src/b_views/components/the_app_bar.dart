part of infinity_youtube_player;

class WebAppBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const WebAppBar({
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
        color: Colorz.black255,
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
            // child: const SuperImage(
            //   loading: false,
            //   height: _appBarHeight,
            //   width: 200,
            //   pic: Iconz.bldrsNameSingleLine,
            //   scale: 0.8,
            // ),
          ),

          const SuperPopMenu(
            corners: Borderers.constantCornersAll15,
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
