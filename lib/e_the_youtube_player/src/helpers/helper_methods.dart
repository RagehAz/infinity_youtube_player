part of the_youtube_player;
// -----------------------------------------------------------------------------

/// HELPERS

// --------------------
abstract class _Helpers {
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
  static bool isGreaterThan({
    required num? number,
    required num? isGreaterThan,
  }){
    bool _output = false;

    if (number != null && isGreaterThan != null){
      _output = number > isGreaterThan;
    }

    return _output;
  }
  // --------------------
}
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------
void blog(dynamic msg, {String? invoker}){

  assert((){
    if (kDebugMode) {
      debugPrint(msg?.toString());
    }
    return true;
  }(), '_');

}
// -----------------------------------------------------------------------------

/// VALUE NOTIFIER SETTER

// --------------------
/// TESTED : WORKS PERFECT
bool setNotifier({
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
// -----------------------------------------------------------------------------

/// ASYNC - SYNC

// --------------------
void asyncInSync(Function? asynchronous) {

  if (asynchronous != null){

    Future<void> _start() async {}

    _start().then((_) async {
      await asynchronous();
    });

  }

}
// --------------------
