import 'package:infinity_youtube/core/services/audio_source_model.dart';

abstract class AudioSourceAnalyzer {
  // -----------------------------------------------------------------------------

  /// SMALLEST

  // --------------------
  /// TESTED : WORKS PERFECT
  static AudioSourceModel? getSmallestAudio({
    required List<AudioSourceModel> audioSources,
  }) {
    AudioSourceModel? _output;

    _loopSync<AudioSourceModel>(
      models: audioSources,
      onLoop: (index, model) {
        if (_output == null) {
          _output = model;
        }
        else {
          final int currentSize = model.size.totalBytes;
          final int previousSize = _output!.size.totalBytes;
          if (_isLesserThan(number: currentSize, isLesserThan: previousSize)) {
            _output = model;
          }
        }
      },
      onListIsEmpty: () => _output = null,
    );

    return _output;
  }
  // --------------------------------------------------------------------------

  /// TOOLS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool _isLesserThan({
    required num? number,
    required num? isLesserThan,
  }){
    bool _output = false;

    if (number != null && isLesserThan != null){
      _output = number < isLesserThan;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _loopSync<T>({
    required List<T>? models,
    required Function(int index, T model) onLoop,
    Function? onListIsEmpty,
  }) {

    if (_checkCanLoop(models) == true){

      for (int i = 0; i < models!.length; i++){
        onLoop(i, models[i]);
      }

    }

    else {
      onListIsEmpty?.call();
    }

  }
  // --------------------
  /// AI TESTED
  static bool _checkCanLoop(List<dynamic>? list) {
    bool _canLoop = false;

    if (list != null && list.isNotEmpty) {
      _canLoop = true;
    }

    return _canLoop;
  }
// -----------------------------------------------------------------------------
}
