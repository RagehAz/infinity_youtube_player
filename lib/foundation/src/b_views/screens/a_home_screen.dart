part of app_foundations;

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
    return TheLayout(
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

          TheYoutubePlayer(
            canvasWidth: context.screenWidth,
            canvasHeight: context.screenWidth * 0.7,
            // isMuted: false,
            // autoPlay: true,
            // loop: false,
            url: 'https://youtu.be/46l2HlRQHk8?si=hmnKYWLPKVGRmXqS',
          ),

          // --------------------

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
