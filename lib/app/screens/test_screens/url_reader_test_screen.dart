import 'package:flutter/material.dart';
import 'package:infinity_youtube/core/layout/the_layout.dart';
import 'package:infinity_youtube/core/services/app_linker.dart';
import 'package:infinity_youtube/core/shared_components/super_box/super_box.dart';
import 'package:infinity_youtube/core/shared_components/super_text/super_text.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/theme/fonts.dart';
import 'package:infinity_youtube/core/utilities/contextual.dart';

class UrlReaderTestScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const UrlReaderTestScreen({
    required this.uri,
    super.key
  });
  // --------------------
  final Uri? uri;
  // --------------------
  @override
  _UrlReaderTestScreenState createState() => _UrlReaderTestScreenState();
  // --------------------------------------------------------------------------
}

class _UrlReaderTestScreenState extends State<UrlReaderTestScreen> {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
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
  String? _log = 'Nothing to log';
  // --------------------
  /*
    infinity://infinity.com/video
    sample://bar/#/book/hello-bar

    https://www.example.com/#/book/hello-www-example
    https://example.com/#/book/hello-example
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return AppLinkListener(
      onEvent: (Uri uri){

        if (mounted){
          setState(() {
            _log = AppLinker.getUriBlogStrings(uri: uri);
          });
        }

      },
      child: TheLayout(
        backgroundColor: Colorz.googleRed,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SuperBox(
                  height: 50,
                text: 'Register msx',
                onTap: () async {

                    await AppLinker.register('infinity');

                },
              ),

              // --------------------
              SuperText(
                boxWidth: context.screenWidth,
                text: _log,
                textHeight: 30,
                margins: 10,
                maxLines: 20,
                font: InfinityFont.regular,
              ),
              // --------------------
            ],
          ),
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
