import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// --------------------------------------------------------------------------

/// SINGLETON INSTANCE APP LINK CLASS

// --------------------
class AppLinker {
  // --------------------------------------------------------------------------

  /// CLASS SINGLETON

  // --------------------
  AppLinker.singleton();
  static final AppLinker _singleton = AppLinker.singleton();
  static AppLinker get instance => _singleton;
  // --------------------------------------------------------------------------

  /// APP LINKS

  // --------------------
  final AppLinks _appLinks = AppLinks();
  AppLinks get appLinks => _appLinks;
  static AppLinks getAppLinksInstance() => AppLinker.instance.appLinks;
  // --------------------------------------------------------------------------

  /// APP LINKS

  // --------------------
  ///
  static StreamSubscription<Uri> listenToAppLinks({
    required Function(Uri uri) onEvent,
  }) {

    final StreamSubscription<Uri> sub = getAppLinksInstance().uriLinkStream.listen((uri) {
      onEvent(uri);
    });

    return sub;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogURI({
    required Uri? uri,
    String invoker = ':',
  }){

    void _blog(dynamic msg){

      assert((){
        if (kDebugMode) {
          debugPrint(msg?.toString());
        }
        return true;
      }(), '_');

    }

    if (uri == null){
      _blog('blogURI $invoker : uri is null');
    }
    else {
      _blog('blogURI $invoker : uri : $uri');
      _blog('blogURI $invoker : uri.toString : $uri');
      _blog('blogURI $invoker : uri.path : ${uri.path}');
      _blog('blogURI $invoker : uri.hashCode : ${uri.hashCode}');
      _blog('blogURI $invoker : uri.data : ${uri.data}');
      _blog('blogURI $invoker : uri.queryParameters : ${uri.queryParameters}');
      _blog('blogURI $invoker : uri.authority : ${uri.authority}');
      _blog('blogURI $invoker : uri.fragment : ${uri.fragment}');
      _blog('blogURI $invoker : uri.hasAbsolutePath : ${uri.hasAbsolutePath}');
      _blog('blogURI $invoker : uri.hasAuthority : ${uri.hasAuthority}');
      _blog('blogURI $invoker : uri.hasEmptyPath : ${uri.hasEmptyPath}');
      _blog('blogURI $invoker : uri.hasFragment : ${uri.hasFragment}');
      _blog('blogURI $invoker : uri.hasPort : ${uri.hasPort}');
      _blog('blogURI $invoker : uri.hasQuery : ${uri.hasQuery}');
      _blog('blogURI $invoker : uri.hasScheme : ${uri.hasScheme}');
      _blog('blogURI $invoker : uri.query : ${uri.query}');
      _blog('blogURI $invoker : uri.host : ${uri.host}');
      _blog('blogURI $invoker : uri.isAbsolute : ${uri.isAbsolute}');
      _blog('blogURI $invoker : uri.pathSegments : ${uri.pathSegments}');
      _blog('blogURI $invoker : uri.port : ${uri.port}');
      _blog('blogURI $invoker : uri.scheme : ${uri.scheme}');
      _blog('blogURI $invoker : uri.userInfo : ${uri.userInfo}');
      _blog('blogURI $invoker : uri.queryParametersAll : ${uri.queryParametersAll}');
      // blog('blogURI $invoker : link.origin : ${uri?.origin}'); // Unhandled Exception: Bad state: Origin is only applicable schemes http and https:
    }

  }
  // --------------------------------------------------------------------------
}
// --------------------------------------------------------------------------

/// LISTENER WIDGET

// --------------------
class AppLinkListener extends StatefulWidget {
  // --------------------------------------------------------------------------
  const AppLinkListener({
    required this.onEvent,
    required this.child,
    super.key
  });
  // --------------------
  final void Function(Uri uri) onEvent;
  final Widget child;
  // --------------------
  @override
  _AppLinkListenerState createState() => _AppLinkListenerState();
  // --------------------------------------------------------------------------
}
// --------------------
class _AppLinkListenerState extends State<AppLinkListener> {
  // -----------------------------------------------------------------------------
  late StreamSubscription<Uri> _stream;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _stream = AppLinker.listenToAppLinks(
      onEvent: widget.onEvent,
    );

    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      // asyncInSync(() async {
      //
      // });

    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  /*
  void asyncInSync(Function? asynchronous) {

    if (asynchronous != null){

      Future<void> _start() async {}

      _start().then((_) async {
        await asynchronous();
      });

    }

  }
   */
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
    _stream.cancel();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return widget.child;
    // --------------------
  }
// -----------------------------------------------------------------------------
}
// --------------------------------------------------------------------------
