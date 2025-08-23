import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_youtube/app/screens/a_home_screen.dart';
import 'package:infinity_youtube/app/screens/b_video_screen.dart';
import 'package:infinity_youtube/app/screens/test_screens/screen_blocking_test_screen.dart';
import 'package:infinity_youtube/app/screens/test_screens/url_reader_test_screen.dart';
// -----------------------------------------------------------------------------

/// MAIN NAV KEY SUPER GLOBAL KEY

// --------------------
final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();
// --------------------
BuildContext? superContext;
// --------------------
/// TESTED : WORKS PERFECT
BuildContext getTheMainContext() {
  return mainNavKey.currentContext ?? superContext!;
}
// -----------------------------------------------------------------------------

/// ROUTER

// --------------------
abstract class Routing {
  // --------------------------------------------------------------------------

  /// ROUTES

  // --------------------
  static const routeHome = 'home';
  static const routeVideo = 'video';
  static const testUrlReader = 'testUrlReader';
  static const testScreenBlocker = 'testScreenBlocker';
  // --------------------------------------------------------------------------

  /// ROUTER

  // --------------------
  static final GoRouter router = GoRouter(
    navigatorKey: mainNavKey,
    initialLocation: '/',
    routes: <GoRoute>[
      // --------------------

      /// HOME
      GoRoute(
        path: '/',
        name: routeHome,
        builder: (context, state) => const HomeScreen(),
      ),

      /// VIDEO
      GoRoute(
        path: '/$routeVideo',
        name: routeVideo,
        builder: (context, state) {
          final params = state.uri.queryParameters;
          final data = params['encrypted'];
          return VideoScreen(
            encryptedData: data,
          );
        },
      ),

      /// URL READER TEST
      GoRoute(
        path: '/$testUrlReader',
        name: testUrlReader,
        builder: (context, state) => const UrlReaderTestScreen(uri: null),
      ),

      /// SCREEN BLOCKER
      GoRoute(
        path: '/$testScreenBlocker',
        name: testScreenBlocker,
        builder: (context, state) => const ScreenBlockingTestScreen(),
      ),

      // --------------------

      // /// DEEP
      // GoRoute(
      //   path: '/$routeRedirect',
      //   name: routeRedirect,
      //   builder: (context, state) => const FTokenWebScreen(),
      // ),

    ],
  );
  // --------------------------------------------------------------------------

  /// APP LINKING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onAppLinkEvent(Uri uri) async {
    // blog(AppLinker.getUriBlogStrings(uri: uri));
    getTheMainContext().go(uri.path);
  }
  // --------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goTo({required String route, String? arg}) async {
    getTheMainContext().goNamed(route);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBack({
    required BuildContext? context,
    String? invoker,
    dynamic passedData,
    bool addPostFrameCallback = false,
  }) async {
    /// OLD
    if (context != null) {
      if (Navigator.canPop(context) == true) {
        if (addPostFrameCallback == true) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, passedData);
          });
        } else {
          await Future.delayed(Duration.zero, () {
            Navigator.pop(context, passedData);
          });
        }
      }
    }
  }
  // --------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
