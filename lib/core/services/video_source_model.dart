import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

@immutable
class VideoSourceModel {
  // --------------------------------------------------------------------------
  const VideoSourceModel({
    required this.video,
    required this.quality,
    required this.bitrate,
    required this.size,
    required this.container,
    required this.videoCodec,
    required this.codec,
    required this.videoResolution,
    required this.videoQuality,
  });
  // --------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  factory VideoSourceModel.fromStreamInfo(VideoOnlyStreamInfo stream) {
    return VideoSourceModel(
      video: stream.url.toString(),
      quality: stream.qualityLabel,
      bitrate: stream.bitrate,
      size: stream.size,
      container: stream.container.name,
      videoCodec: stream.videoCodec,
      codec: stream.codec.toString(),
      videoResolution: stream.videoResolution.toString(),
      videoQuality: stream.videoQuality.name,
    );
  }
  // --------------------------------------------------------------------------

  /// PARAMETERS

  // --------------------
  final String video;
  final String quality;
  final Bitrate bitrate;
  final FileSize size;
  final String container;
  final String videoCodec;
  final String codec;
  final String videoResolution;
  final String videoQuality;
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() => '''
VideoSourceModel(
  video: $video,
  quality: $quality,
  bitrate: $bitrate,
  size: $size,
  container: $container,
  videoCodec: $videoCodec,
  codec: $codec,
  videoResolution: $videoResolution,
  videoQuality: $videoQuality,
)
''';
  // --------------------
  @override
  bool operator ==(Object other) {

    if (identical(this, other)){
      return true;
    }
    else {
      return other is VideoSourceModel &&
          other.video == video &&
          other.quality == quality &&
          other.bitrate == bitrate &&
          other.size == size &&
          other.container == container &&
          other.videoCodec == videoCodec &&
          other.codec == codec &&
          other.videoResolution == videoResolution &&
          other.videoQuality == videoQuality;
    }

  }
  // --------------------
  @override
  int get hashCode =>
      video.hashCode^
      quality.hashCode^
      bitrate.hashCode^
      size.hashCode^
      container.hashCode^
      videoCodec.hashCode^
      codec.hashCode^
      videoResolution.hashCode^
      videoQuality.hashCode;
  // --------------------------------------------------------------------------
}
