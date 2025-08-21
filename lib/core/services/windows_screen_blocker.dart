import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

abstract class WindowsScreenShotBlocker {
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
