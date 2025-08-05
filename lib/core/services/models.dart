import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Vid {
  Vid({
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

  factory Vid.fromStreamInfo(VideoOnlyStreamInfo stream) {
    return Vid(
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
  final String video;
  final String quality;
  final Bitrate bitrate;
  final FileSize size;
  final String container;
  final String videoCodec;
  final String codec;
  final String videoResolution;
  final String videoQuality;
}

class Aud {
  Aud({
    required this.audio,
    required this.quality,
    required this.bitrate,
    required this.size,
    required this.container,
  });

  factory Aud.fromStreamInfo(AudioOnlyStreamInfo stream) {
    return Aud(
      audio: stream.url.toString(),
      quality: stream.qualityLabel,
      bitrate: stream.bitrate,
      size: stream.size,
      container: stream.container.name,
    );
  }
  final String audio;
  final String quality;
  final Bitrate bitrate;
  final FileSize size;
  final String container;
}
