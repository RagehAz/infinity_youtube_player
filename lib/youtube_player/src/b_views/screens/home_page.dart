part of infinity_youtube_player;

class HomePage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const HomePage({
    super.key
  });
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return WebLayout(
      child: VerticalFloatingList(
        width: _screenWidth,
        height: _screenHeight,
        boxAlignment: Alignment.topCenter,
        padding: const EdgeInsets.only(
          top: Scale.appBarHeight + 10,
          // bottom: 0,
        ),
        columnChildren: <Widget>[

          // --------------------

          Container(
            width: 100,
            height: 200,
            color: Colorz.googleRed,
          ),

          // --------------------

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
