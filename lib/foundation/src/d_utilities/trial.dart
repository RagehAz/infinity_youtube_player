// ignore_for_file: avoid_catches_without_on_clauses

part of app_foundations;
// -----------------------------------------------------------------------------

/// TRY AND CATCH

// --------------------
/// TESTED : WORKS PERFECT
Future<void> tryAndCatch({
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
/// TESTED : WORKS PERFECT
Future<bool> tryCatchAndReturnBool({
  required Future<void> Function() functions,
  ValueChanged<String>? onError,
  int? timeout,
  String invoker = 'tryCatchAndReturnBool',
}) async {
  /// IF FUNCTIONS SUCCEED RETURN TRUE, IF ERROR CAUGHT RETURNS FALSE
  bool _success = false;

  /// TRY FUNCTIONS
  try {

    ///  WITHOUT TIMEOUT
    if (timeout == null) {
      await functions();
      _success = true;
    }

    /// WITH TIMEOUT
    else {
      await functions().timeout(
          Duration(seconds: timeout),
          onTimeout: () {
            _success = false;
            if (onError != null){
              onError('Timeout ( $invoker ) after ( $timeout) seconds');
            }
          });
    }

  }

  /// CATCH EXCEPTION ERROR
  // on Exception : this does not work on web
  catch (error) {

    blog('$invoker : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    _success = false;
  }

  return _success;
}
// -----------------------------------------------------------------------------
