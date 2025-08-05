import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

@immutable
class AudioSourceModel {
  // --------------------------------------------------------------------------
  const AudioSourceModel({
    required this.audio,
    required this.quality,
    required this.bitrate,
    required this.size,
    required this.container,
  });
  // --------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  factory AudioSourceModel.fromStreamInfo(AudioOnlyStreamInfo stream) {
    return AudioSourceModel(
      audio: stream.url.toString(),
      quality: stream.qualityLabel,
      bitrate: stream.bitrate,
      size: stream.size,
      container: stream.container.name,
    );
  }
  // --------------------------------------------------------------------------

  /// PARAMETERS

  // --------------------
  final String audio;
  final String quality;
  final Bitrate bitrate;
  final FileSize size;
  final String container;
  // --------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => '''
AudioSourceModel(
  audio: $audio,
  quality: $quality,
  bitrate: $bitrate,
  size: ${size.totalBytes} bytes,
  container: $container,
)
''';
  // --------------------
  @override
  bool operator ==(Object other) {

    if (identical(this, other)){
      return true;
    }
    else {
      return other is AudioSourceModel &&
          other.audio == audio &&
          other.quality == quality &&
          other.bitrate == bitrate &&
          other.size == size &&
          other.container == container;
    }

  }
  // --------------------
  @override
  int get hashCode =>
      audio.hashCode^
      quality.hashCode^
      bitrate.hashCode^
      size.hashCode^
      container.hashCode;
  // --------------------------------------------------------------------------
}
