part of super_box;

abstract class _Helpers {
  // -----------------------------------------------------------------------------
  static const Color nothing = Color.fromARGB(0, 255, 255, 255);
  static const Color black20 = Color.fromARGB(20, 0, 0, 0);
  static const Color white10 = Color.fromARGB(10, 255, 255, 255);
  static const Color white50 = Color.fromARGB(50, 255, 255, 255);
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsSVG(dynamic object) {
    return getExtensionFromPath(object) == 'svg';
  }
  // --------------------
  /// AI TESTED
  static String? getExtensionFromPath(dynamic path){
    String? _output;

    if (path != null && path is String){

      final bool _containsExtension = stringContainsSubString(
        string: path,
        subString: '.',
      );

      if (_containsExtension == true){

        _output = removeTextBeforeLastSpecialCharacter(
          text: path,
          specialCharacter: '.',
        );

      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static String? removeTextBeforeLastSpecialCharacter({
    required String? text,
    required String specialCharacter,
  }) {
    String? _result = text;

    if (isEmpty(text) == false){

      final bool _textContainsChar = stringContainsSubString(
        string: text,
        subString: specialCharacter,
      );

      if (_textContainsChar == true) {

        final int _position = _result!.lastIndexOf(specialCharacter);

        _result = text == null ? null
            :
        (_position != -1) ? text.substring(_position + 1, text.length)
            :
        text;
      }

    }

    return _result;
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
  // --------------------
  /// AI TESTED
  static bool stringContainsSubString({
    required String? string,
    required String? subString,
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {
      if (string.toLowerCase().contains(subString.toLowerCase()) == true) {
        _itContainsIt = true;
      }
    }

    return _itContainsIt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius superCorners({
    dynamic corners,
  }) {
    BorderRadius _corner;

    if (corners == null || corners == 0) {
      _corner = BorderRadius.zero;
    }

    else if (corners is num) {
      _corner = cornerAll(corners.toDouble());
    }

    else if (corners is BorderRadius) {
      _corner = corners;
    }

    else {
      final Error _error = ArgumentError('superBorder corners is invalid', 'superBorder');

      throw _error;
    }

    return _corner;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BorderRadius cornerAll(double? corners) {

    if (corners == null){
      return BorderRadius.zero;
    }
    else {
      return BorderRadius.all(Radius.circular(corners));
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsJPGorPNG(dynamic object) {
    bool _objectIsJPGorPNG = false;

    if (object != null){
      if (
          getExtensionFromPath(object) == 'jpeg'
          ||
          getExtensionFromPath(object) == 'jpg'
          ||
          getExtensionFromPath(object) == 'png'
      ) {
        _objectIsJPGorPNG = true;
      }

      else {
        _objectIsJPGorPNG = false;
      }

    }

    return _objectIsJPGorPNG;
  }
  // -----------------------------------------------------------------------------
}
