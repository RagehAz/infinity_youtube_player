part of infinity_youtube_player;

class WebLayout extends StatelessWidget {
  // --------------------------------------------------------------------------
  const WebLayout({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return Scaffold(
      /// INSETS
      resizeToAvoidBottomInset: false, /// if false : prevents keyboard from pushing pyramids up / bottom sheet
      // resizeToAvoidBottomPadding: false,
      backgroundColor: Colorz.black255,
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            /// BODY
            SizedBox(
              width: _screenWidth,
              height: _screenHeight,
              child: child,
            ),

            /// APP BAR
            const WebAppBar(),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
