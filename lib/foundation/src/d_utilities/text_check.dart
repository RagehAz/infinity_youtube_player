part of app_foundations;

/// => AI TESTED
abstract class TextCheck {
  // -----------------------------------------------------------------------------

  /// REG EXP

  // --------------------
  static const String urlPattern = r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?';
  // -----------------------------------------------------------------------------

  /// BAD WORDS

  // --------------------
  /// AI TESTED
  static bool containsBadWords({
    required String? text,
    required List<String> badWords,
  }){
    bool _userIsSayingSomeNastyShit = false;

    if (TextCheck.isEmpty(text) == false) {

      for (int i = 0; i < badWords.length; i++) {
        final bool _hasBadWord = stringContainsSubString(
          string: text,
          subString: badWords[i],
        );

        if (_hasBadWord == true) {
          _userIsSayingSomeNastyShit = true;
          break;
        }
      }

    }

    return _userIsSayingSomeNastyShit;
  }
  // -----------------------------------------------------------------------------

  /// LANGUAGE CHECK

  // --------------------
  /// AI TESTED
  static bool textIsEnglish(String? val) {

    if (val == null || val.trim().isEmpty == true){
      return true;
    }

    else {
    final RegExp exp = RegExp('[a-zA-Z]', multiLine: true, unicode: true);
    bool textIsEnglish = true;

    /// if you want to check the last character input by user let the [characterNumber = val.length-1;]
    const int characterNumber = 0;

      if (exp.hasMatch(val.substring(characterNumber)) && val.substring(characterNumber) != ' ') {
        textIsEnglish = true;
      }

      else if (!exp.hasMatch(val.substring(characterNumber)) &&
          val.substring(characterNumber) != ' ') {
        textIsEnglish = false;
      }

      return textIsEnglish;
    }
  }
  // -----------------------------------------------------------------------------

  /// CASE CHECK

  // --------------------
  /// AI TESTED
  static bool verseIsUpperCase(String? text){
    bool _isUpperCase = false;

    if (TextCheck.isEmpty(text) == false){
      if (text!.toUpperCase() == text){
        _isUpperCase = true;
      }
    }

    return _isUpperCase;
  }
  // -----------------------------------------------------------------------------
  /// AI TESTED
  static bool textControllersAreIdentical({
    required TextEditingController? controller1,
    required TextEditingController? controller2,
  }){

    if (controller1 == null && controller2 == null){
      return true;
    }

    else if (controller1 != null && controller2 != null){

      if (
          controller1.text == controller2.text &&
          controller1.hashCode == controller2.hashCode
      ){
        return true;
      }

      else {
        return false;
      }

    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// TEXT CONTROLLER CREATORS

  // --------------------
  /// AI TESTED
  static List<TextEditingController> createEmptyTextControllers(int? length) {
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (length != null && length != 0){
      for (int i = 0; i < length; i++) {
        _controllers.add(TextEditingController());
    }
    }

    return _controllers;
  }
  // -----------------------------------------------------------------------------

  /// CONTAINS

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
  /// AI TESTED
  static bool stringContainsSubStringRegExp({
    required String? string,
    required String? subString,
    bool caseSensitive = false,
    // bool multiLine = false
  }) {
    bool _itContainsIt = false;

    if (string != null && subString != null) {

      final RegExp pattern = RegExp(subString,
        caseSensitive: caseSensitive,
        // multiLine: multiLine // mesh shaghal w mesh wa2to
      );
      final Iterable matches = pattern.allMatches(string);

      if (matches.isNotEmpty) {
        _itContainsIt = true;
      }

    }

    return _itContainsIt;
  }
  // --------------------
  /// AI TESTED
  static bool stringStartsExactlyWith({
    required String? text,
    required String? startsWith, // http
  }){
    bool _output = false;

    if (TextCheck.isEmpty(text) == false && TextCheck.isEmpty(startsWith) == false){

      final String? _cutText = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: text,
        numberOfChars: startsWith!.length,
      );

      if (_cutText == startsWith){
        _output = true;
      }

    }

    return _output;
  }
  // --------------------
  /// AI TESTED
  static List<String>? getStringsStartingExactlyWith({
    required String? startWith,
    required List<String>? strings,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(strings) == true && TextCheck.isEmpty(startWith) == false){

      for (final String string in strings!){

        final bool _startsIndeed = stringStartsExactlyWith(
            text: string,
            startsWith: startWith,
        );

        if (_startsIndeed == true){
          _output.add(string);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getStringsContainingThis({
    required List<String> strings,
    required String? subString,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(strings) == true && TextCheck.isEmpty(subString) == false){

      for (final String text in strings){

        final bool _contains = TextCheck.stringContainsSubString(
          string: text,
          subString: subString,
        );

        if (_contains == true){
          _output.add(text);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// LENGTH

  // --------------------
  /// AI TESTED
  static bool isShorterThanOrEqualTo({
    required String? text,
    required int? length,
  }){
    bool _isShorter = false;

    if (TextCheck.isEmpty(text) == true || length == null){
      _isShorter = true;
    }
    else {
      _isShorter = text!.length <= length;
    }

    return _isShorter;
  }
  // --------------------
  /// AI TESTED
  static bool isShorterThan({
    required String? text,
    required int? length,
  }){
    bool _isShorter = false;

    if (TextCheck.isEmpty(text) == true || length == null){
      _isShorter = true;
    }
    else {
      _isShorter = text!.length < length;
    }

    return _isShorter;
  }
  // -----------------------------------------------------------------------------
}
