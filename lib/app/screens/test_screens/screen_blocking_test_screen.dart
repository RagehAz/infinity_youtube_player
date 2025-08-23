import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/services/screen_blocker.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/fonts.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';

class ScreenBlockingTestScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const ScreenBlockingTestScreen({
    super.key
  });
  // --------------------
  @override
  _ScreenBlockingTestScreenState createState() => _ScreenBlockingTestScreenState();
  // --------------------------------------------------------------------------
}

class _ScreenBlockingTestScreenState extends State<ScreenBlockingTestScreen> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _screenIsBlocked = ScreenBlocker.instance.isBlocked;

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // asyncInSync(() async {
      //
      //   await _triggerLoading(setTo: true);
      //   /// GO BABY GO
      //   await _triggerLoading(setTo: false);
      //
      // });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    super.dispose();
  }
  // --------------------
  bool _screenIsBlocked = true;
  // --------------------
  /*
    infinity://infinity.com/bobo
    sample://bar/#/book/hello-bar

    https://www.example.com/#/book/hello-www-example
    https://example.com/#/book/hello-example
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      backgroundColor: Colorz.googleRed,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // --------------------
            SuperText(
              boxWidth: context.screenWidth,
              text: _screenIsBlocked ? 'Screen should be blocked' : 'Screen is now visible',
              textHeight: 30,
              margins: 10,
              maxLines: 20,
              font: InfinityFont.regular,
            ),
            // --------------------
            SuperBox(
              height: 50,
              text: _screenIsBlocked ? 'Tap to unblock screen' : 'Click to block screen',
              onTap: () async {

                /// SHOULD UNBLOCK
                if (_screenIsBlocked){
                  await ScreenBlocker.restore();
                }

                /// SHOULD BLOCK
                else {
                  await ScreenBlocker.block();
                }

                if (mounted){
                  setState(() {
                    _screenIsBlocked = ScreenBlocker.instance.isBlocked;
                  });
                }

              },
            ),
            // --------------------
          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
