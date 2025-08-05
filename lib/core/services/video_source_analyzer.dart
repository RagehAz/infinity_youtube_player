import 'package:infinity_youtube/core/services/video_source_model.dart';

abstract class VideoSourceAnalyzer {
  // -----------------------------------------------------------------------------

  /// SMALLEST OF EACH

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<VideoSourceModel> getSmallestVideoOfEachQuality({
    required List<VideoSourceModel> videoSources,
  }) {
    final Map<String, VideoSourceModel> best = {};

    _loopSync(
      models: videoSources,
      onLoop: (int index, VideoSourceModel source){

        final String quality = source.quality;
        final VideoSourceModel? existing = best[quality];

        /// NOT THERE
        if (existing == null){
          best[quality] = source;
        }

        /// FOUND
        else {

          final bool _isSmaller = _isLesserThan(
            number: source.size.totalBytes,
            isLesserThan: existing.size.totalBytes,
          );

          if (_isSmaller == true) {
            best[quality] = source;
          }

        }

      }
    );

    return _sortByQualityDescending(
      videoSources: best.values.toList(),
    );
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<VideoSourceModel> _sortByQualityDescending({
    required List<VideoSourceModel> videoSources,
  }) {
    if (_checkCanLoop(videoSources) == false){
      return const <VideoSourceModel>[];
    }
    else {
      final List<VideoSourceModel> sorted = List.from(videoSources);
      sorted.sort((a, b) {
        final qa = _parseQuality(a.quality);
        final qb = _parseQuality(b.quality);
        return qb.compareTo(qa); // descending
      });
      return sorted;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int _parseQuality(String quality) {
    final num = int.tryParse(quality.replaceAll(RegExp(r'[^0-9]'), ''));
    return num ?? 0;
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
