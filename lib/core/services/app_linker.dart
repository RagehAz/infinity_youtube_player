import 'dart:async';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:infinity_youtube/app/the_youtube_player/the_you_tube_player.dart';
import 'package:win32_registry/win32_registry.dart';
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
  /// TESTED : WORKS PERFECT
  static StreamSubscription<Uri> listenToAppLinks({
    required Function(Uri uri) onEvent,
  }) {

    final StreamSubscription<Uri> sub = getAppLinksInstance().uriLinkStream.listen((uri) {
      onEvent(uri);
    });

    return sub;
  }
  // -----------------------------------------------------------------------------

  /// REGISTER

  // --------------------
  /// NEED ADJUSTMENT BECAUSE ...
  static Future<void> register(String scheme) async {
    final String appPath = Platform.resolvedExecutable;

    final String protocolRegKey = 'Software\\Classes\\$scheme';
    const RegistryValue protocolRegValue = RegistryValue.string(
      'URL Protocol',
      '',
    );
    const String protocolCmdRegKey = r'shell\open\command';
    final RegistryValue protocolCmdRegValue = RegistryValue.string(
      '',
      '"$appPath" "%1"',
    );

    final regKey = Registry.currentUser.createKey(protocolRegKey);
    regKey.createValue(protocolRegValue);
    regKey.createKey(protocolCmdRegKey).createValue(protocolCmdRegValue);

    blog('appPath($appPath)');
    blog('protocolRegKey($protocolRegKey)');
    blog('protocolRegValue($protocolRegValue)');
    blog('protocolCmdRegKey($protocolCmdRegKey)');
    blog('protocolCmdRegValue($protocolCmdRegValue)');
    blog('regKey($regKey)');
    blog('regKey.subkeyNames(${regKey.subkeyNames})');

  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUriBlogStrings({
    required Uri? uri,
  }){
    String _output = 'uri is null';

    if (uri != null){

      _output =
          'uri($uri)\n'
          'uri.toString($uri)\n'
          'uri.path(${uri.path})\n'
          'uri.hashCode(${uri.hashCode})\n'
          'uri.data(${uri.data})\n'
          'uri.queryParameters(${uri.queryParameters})\n'
          'uri.authority(${uri.authority})\n'
          'uri.fragment(${uri.fragment})\n'
          'uri.hasAbsolutePath(${uri.hasAbsolutePath})\n'
          'uri.hasAuthority(${uri.hasAuthority})\n'
          'uri.hasEmptyPath(${uri.hasEmptyPath})\n'
          'uri.hasFragment(${uri.hasFragment})\n'
          'uri.hasPort(${uri.hasPort})\n'
          'uri.hasQuery(${uri.hasQuery})\n'
          'uri.hasScheme(${uri.hasScheme})\n'
          'uri.query(${uri.query})\n'
          'uri.host(${uri.host})\n'
          'uri.isAbsolute(${uri.isAbsolute})\n'
          'uri.pathSegments(${uri.pathSegments})\n'
          'uri.port(${uri.port})\n'
          'uri.scheme(${uri.scheme})\n'
          'uri.userInfo(${uri.userInfo})\n'
          'uri.queryParametersAll(${uri.queryParametersAll})';
    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static const String _urlPattern = r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isURLFormat(dynamic object) {

    bool _isURLFormat = false;

    if (object != null && object is String) {

      final RegExp regExp = RegExp(_urlPattern);
      _isURLFormat = regExp.hasMatch(object);

    }

    return _isURLFormat;
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
