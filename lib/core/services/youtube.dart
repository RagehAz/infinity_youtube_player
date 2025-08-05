import 'package:infinity_youtube/core/services/models.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

typedef YtSource = ({List<Vid> video, List<Aud> audio});

class YoutubeParser {
  // --------------------------------------------------------------------------

  /// INSTANCE

  // --------------------
  final YoutubeExplode explode = YoutubeExplode();
  // --------------------------------------------------------------------------

  /// PARSER

  // --------------------
  Future<YtSource> parse(String url) async {

    final StreamManifest manifest = await explode.videos.streams.getManifest(url);

    final List<Vid> videoList = <Vid>[];
    final List<Aud> audioList = <Aud>[];

    /// LOOP VIDEOS
    for (final stream in manifest.videoOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }
      videoList.add(Vid.fromStreamInfo(stream));
    }

    /// LOOP AUDIOS
    for (final stream in manifest.audioOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }
      audioList.add(Aud.fromStreamInfo(stream));
    }

    return (video: videoList, audio: audioList);
  }
  // --------------------------------------------------------------------------
}
