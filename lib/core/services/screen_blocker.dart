import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';
import 'dart:io';
import 'package:no_screenshot/no_screenshot.dart';

class ScreenBlocker {
  // --------------------------------------------------------------------------
  /// SINGLETON
  ScreenBlocker._internal();
  static final ScreenBlocker _singleton = ScreenBlocker._internal();
  static ScreenBlocker get instance => _singleton;
  // --------------------
  bool _isBlocked = false;
  bool get isBlocked => _isBlocked;
  // --------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  late final _ScreenBlockerClass _blocker;
  // --------------------
  static Future<void> init() async {
    instance._blocker = _ScreenShotBlockerFactory.create();
    await instance._blocker.init();
    instance._isBlocked = true;
  }
  // --------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  static Future<void> block() async {
    await instance._blocker.block();
    instance._isBlocked = true;
  }
  // --------------------
  static Future<void> restore() async {
    await instance._blocker.restore();
    instance._isBlocked = false;
  }
  // --------------------------------------------------------------------------
}

class _ScreenShotBlockerFactory {
  // --------------------------------------------------------------------------

  /// START

  // --------------------
  static _ScreenBlockerClass create() {
    if (Platform.isWindows) {
      return _WindowsScreenShotBlocker();
    }
    else {
      return _MobileScreenShotBlocker();
    }
  }
  // --------------------------------------------------------------------------
}

abstract class _ScreenBlockerClass {
  // --------------------
  Future<void> init();
  // --------------------
  Future<void> block();
  // --------------------
  Future<void> restore();
  // --------------------
}

class _WindowsScreenShotBlocker implements _ScreenBlockerClass {
  // --------------------
  @override
  Future<void> init() async {
    await block(); // always start blocked
  }
  // --------------------
  @override
  Future<void> block() async {
    final Pointer<Utf16> className = 'FLUTTER_RUNNER_WIN32_WINDOW'.toNativeUtf16();
    final int window = FindWindow(className, nullptr);
    SetWindowDisplayAffinity(window, WDA_EXCLUDEFROMCAPTURE);
    free(className);
  }
  // --------------------
  @override
  Future<void> restore() async {
    final Pointer<Utf16> className = 'FLUTTER_RUNNER_WIN32_WINDOW'.toNativeUtf16();
    final int window = FindWindow(className, nullptr);
    SetWindowDisplayAffinity(window, WDA_NONE);
    free(className);
  }
// --------------------
}

class _MobileScreenShotBlocker implements _ScreenBlockerClass {
  // --------------------
  final NoScreenshot _instance = NoScreenshot.instance;
  // --------------------
  @override
  Future<void> init() async {
    await block();
  }
  // --------------------
  @override
  Future<void> block() async {
    await _instance.screenshotOff();
  }
  // --------------------
  @override
  Future<void> restore() async {
    await _instance.screenshotOn();
  }
  // --------------------
}

/*
abstract class _OLDWindowsScreenShotBlocker {
  // --------------------------------------------------------------------------

  /// BLOCK

  // --------------------
  /// TESTED : WORKS PERFECT
  static void block() {
    final Pointer<Utf16> className = 'FLUTTER_RUNNER_WIN32_WINDOW'
        .toNativeUtf16();
    final int window = FindWindow(className, nullptr);
    SetWindowDisplayAffinity(window, WDA_EXCLUDEFROMCAPTURE);
    free(className);
  }
  // -----------------------------------------------------------------------------

  /// RESTORE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void restore() {
    final Pointer<Utf16> className = 'FLUTTER_RUNNER_WIN32_WINDOW'
        .toNativeUtf16();
    final int window = FindWindow(className, nullptr);
    SetWindowDisplayAffinity(window, WDA_NONE);
    free(className);
  }

  // -----------------------------------------------------------------------------
}

 */
