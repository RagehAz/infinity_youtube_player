import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

abstract class WindowsScreenShotBlocker {
  // --------------------------------------------------------------------------

  /// BLOCK

  // --------------------
  /// TESTED : WORKS PERFECT
  static void block() {
    final Pointer<Utf16> windowTitle = 'infinity_youtube'.toNativeUtf16();
    final int window = FindWindow(nullptr, windowTitle);
    SetWindowDisplayAffinity(window, WDA_EXCLUDEFROMCAPTURE);
    free(windowTitle);
  }
  // -----------------------------------------------------------------------------

  /// RESTORE

  // --------------------
  /// TESTED : WORKS PERFECT
  static void restore() {
    final Pointer<Utf16> windowTitle = 'infinity_youtube'.toNativeUtf16();
    final int window = FindWindow(nullptr, windowTitle);
    SetWindowDisplayAffinity(window, WDA_NONE);
    free(windowTitle);
  }
  // -----------------------------------------------------------------------------
}
