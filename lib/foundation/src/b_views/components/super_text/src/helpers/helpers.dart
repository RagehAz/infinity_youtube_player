part of super_text;

abstract class _Helpers {
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets superMargins({
    required dynamic margin,
  }) {
    if (margin == null || margin == 0) {
      return EdgeInsets.zero;
    }

    else if (margin.runtimeType == double) {
      return EdgeInsets.all(margin);
    }

    else if (margin.runtimeType == int) {
      return EdgeInsets.all(margin.toDouble());
    }

    else if (margin.runtimeType == EdgeInsets) {
      return margin;
    }

    else {
      return margin;
    }
  }
  // --------------------
  /// AI TESTED
  static bool isEmpty(String? string) {

    if (string == null || string == '' || string.isEmpty == true

    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == ''
    // ||
    // TextMod.cutFirstCharacterAfterRemovingSpacesFromAString(_string) == null

    ) {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------
  void x(){}
}
