import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/router/router.dart';
import 'package:infinity_youtube/core/theme/colorz.dart';
import 'package:infinity_youtube/core/utilities/app_scroll_behavior.dart';
import 'package:no_screenshot/no_screenshot.dart';

Future<void> main() async {
  // final WidgetsBinding _binding =
  WidgetsFlutterBinding.ensureInitialized();
  await startSecurity();

  runApp(const Starter());
}

Future<void> startSecurity() async {
  await NoScreenshot.instance.screenshotOff();
}

class Starter extends StatefulWidget {
  // --------------------------------------------------------------------------
  const Starter({super.key});
  // --------------------
  @override
  _StarterState createState() => _StarterState();
  // --------------------------------------------------------------------------
}

class _StarterState extends State<Starter> with WidgetsBindingObserver {
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit == true && mounted == true) {
      _isInit = false;
      asyncInSync(() async {});
    }
    super.didChangeDependencies();
  }

  // --------------------
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // --------------------
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      blog('Starter.didChangeAppLifecycleState(RESUMED)');
    } else if (state == AppLifecycleState.inactive) {
      blog('Starter.didChangeAppLifecycleState(INACTIVE)');
    } else if (state == AppLifecycleState.paused) {
      blog('Starter.didChangeAppLifecycleState(PAUSED)');
    } else if (state == AppLifecycleState.detached) {
      blog('Starter.didChangeAppLifecycleState(DETACHED)');
    }
    super.didChangeAppLifecycleState(state);
  }

  // ---------------------
  void asyncInSync(Function? asynchronous) {
    if (asynchronous != null) {
      Future<void> _start() async {}

      _start().then((_) async {
        await asynchronous();
      });
    }
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  void blog(dynamic msg, {String? invoker}) {
    assert(() {
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');
  }

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    superContext = context;

    return MaterialApp.router(
      /// KEYS
      // key: ,
      // scaffoldMessengerKey: ,
      // restorationScopeId: ,
      // useInheritedMediaQuery: true,
      /// SCROLLING
      scrollBehavior: const AppScrollBehavior(),

      /// DEBUG
      debugShowCheckedModeBanner: false,

      /// THEME
      title: 'Infinity youtube player',
      theme: ThemeData(
        canvasColor: Colorz.nothing,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colorz.youtube,
          selectionColor: Colorz.white50,
        ),
      ),

      /// ROUTES
      routerConfig: Routing.router,
    );
  }

  // -----------------------------------------------------------------------------
}
