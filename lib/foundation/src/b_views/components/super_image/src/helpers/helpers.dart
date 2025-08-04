// ignore_for_file: unused_element, avoid_catches_without_on_clauses

part of super_image;

abstract class _Helpers {
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUint8List(dynamic object) {
    bool _isUint8List = false;

    if (object != null) {
      if (
      object is Uint8List
          ||
          object is Uint8List?
          ||
          object.runtimeType.toString() == '_Uint8ArrayView'
          ||
          object.runtimeType.toString() == 'Uint8List'
      ) {
        _isUint8List = true;
      }
    }

    return _isUint8List;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsFile(dynamic file) {
    bool _isFile = false;

    if (file != null) {

      final bool isFileA = file is File || file is File?;
      final bool isFileB = file.runtimeType.toString() == '_File';

      if (isFileA == true || isFileB == true) {
        _isFile = true;
      }

    }

    else {
      blog('objectIsFile : isFile : null');
    }

    return _isFile;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isAbsoluteURL(dynamic object) {
    bool _isValidURL = false;

    if (object != null && object is String) {

      final String _url = object.trim();

      final bool _hasWrongSlashes1 = stringContainsSubString(string: _url, subString: 'https:///');
      final bool _hasWrongSlashes2 = stringContainsSubString(string: _url, subString: 'http:///');
      final bool _slashesAreGood = _hasWrongSlashes1 == false && _hasWrongSlashes2 == false;

      if (_slashesAreGood == true){

        tryAndCatch(
            invoker: 'ObjectCheck.isAbsoluteURL',
            functions: () async {
              final parsedUri = Uri.parse(_url);
              _isValidURL = parsedUri.isAbsolute || (parsedUri.scheme.isNotEmpty && parsedUri.host.isNotEmpty);
            },
            onError: (String? error){
              // blog('1/2: ObjectCheck.isAbsoluteURL : tryAndCatch ERROR : $error');
              // blog('2/2: ObjectCheck.isAbsoluteURL : object : $object');
            }
        );

      }

    }

    return _isValidURL;
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsSVG(dynamic object) {
    return getExtensionFromPath(object) == 'svg';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUiImage(dynamic object){
    bool _isUiImage = false;

    if (object != null){

      if (object is ui.Image){
        _isUiImage = true;
      }

    }

    return _isUiImage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsImgImage(dynamic object){
    bool _isImgImage = false;

    if (object != null){

      if (object is img.Image){
        _isImgImage = true;
      }

    }

    return _isImgImage;
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
  static Future<bool> checkLocalAssetExists(dynamic asset) async {
    bool _isFound = false;

    if (asset is String){
      if (_Helpers.isEmpty(asset) == false){

        final ByteData? _bytes = await byteDataFromLocalAsset(
          pathOrURL: asset,
        ).catchError(
              (Object? error) {
            // blog('LocalAssetChecker : _checkAsset : error : ${error.toString()}');

            if (error == null) {
              _isFound = true;
            }
            else {
              _isFound = false;
            }

            return null;
          },
        );

        _isFound = _bytes != null;
      }
    }

    return _isFound;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData?> byteDataFromLocalAsset({
    required String? pathOrURL,
  }) async {
    /// NOTE : Asset path can be local path or url
    ByteData? _byteData;

    if (_Helpers.isEmpty(pathOrURL) == false){
      await _Helpers.tryAndCatch(
        invoker: 'Byter.byteDataFromLocalAsset',
        functions: () async {

          _byteData = await rootBundle.load(pathOrURL!);

        },
      );
    }

    return _byteData;
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
  /// TESTED : WORKS PERFECT
  static bool setNotifier({
    required ValueNotifier<dynamic>? notifier,
    required bool mounted,
    required dynamic value,
    bool addPostFrameCallBack = false,
    Function? onFinish,
    bool shouldHaveListeners = false,
    String? invoker,
  }){
    bool _done = false;

    if (mounted == true){
      // blog('setNotifier : setting to ${value.toString()}');

      if (notifier != null){

        if (invoker != null){
          blog('-> setNotifier($invoker) : $value != <${notifier.value.runtimeType}>${notifier.value} ? ${value != notifier.value}');
        }

        if (value != notifier.value){

          /// ignore: invalid_use_of_protected_member
          if (shouldHaveListeners == false || notifier.hasListeners == true){

            if (addPostFrameCallBack == true){
              WidgetsBinding.instance.addPostFrameCallback((_){
                notifier.value  = value;
                if(onFinish != null){
                  onFinish();
                }
              });
            }

            else {
              notifier.value  = value;
              if(onFinish != null){
                onFinish();
              }
              _done = true;
            }

          }

        }

      }

    }

    return _done;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blog(dynamic msg, {String? invoker}){

    assert((){
      if (kDebugMode) {
        debugPrint(msg?.toString());
      }
      return true;
    }(), '_');

  }
  // --------------------
  /// AI TESTED
  static bool checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
  // --------------------
  /// AI TESTED
  static bool checkListsAreIdentical({
    required List<dynamic>? list1,
    required List<dynamic>? list2
  }) {
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (checkCanLoop(list1) == true && checkCanLoop(list2) == true){

      if (list1!.length != list2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( $list1 )');
        // blog(' ---> lis2 is ( $list2 )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          if (list1[i] != list2[i]) {
            // blog('items at index ( $i ) do not match : ( ${list1[i]} ) <=> ( ${list2[i]} )');

            if (list1[i].toString() == list2[i].toString()){
              // blog('but they are equal when converted to string');
              _listsAreIdentical = true;
            }
            else {
              // blog('and they are not equal when converted to string');
              _listsAreIdentical = false;
              break;
            }

          }

          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> tryAndCatch({
    required Future<void> Function() functions,
    required String invoker,
    ValueChanged<String>? onError,
    Function? onTimeout,
    int? timeout,
  }) async {

    try {

      ///  WITHOUT TIMEOUT
      if (timeout == null) {
        await functions();
      }

      /// WITH TIMEOUT
      else {
        await functions().timeout(
            Duration(seconds: timeout),
            onTimeout: () async {

              if (onError != null){
                onError('Timeout ( $invoker ) after ( $timeout) seconds');
              }

              onTimeout?.call();

            });
      }


    }
    // on Exception : this does not work on web
    catch (error) {

      if (onError == null){
        blog('$invoker : tryAndCatch ERROR : $error');
      }

      else {
        onError(error.toString());
      }

      // throw(error);
    }

  }
  // -----------------------------------------------------------------------------
}
