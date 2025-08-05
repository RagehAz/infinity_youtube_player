import 'package:infinity_youtube/core/services/models.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

typedef YtSource = ({List<Vid> video, List<Aud> audio});

class YoutubeParser {
  final YoutubeExplode explode = YoutubeExplode();
  Future<YtSource> parse(String url) async {
    final manifest = await explode.videos.streams.getManifest(url);
    final videoList = <Vid>[];
    final audioList = <Aud>[];
    for (final stream in manifest.videoOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }

      videoList.add(Vid.fromStreamInfo(stream));
    }
    for (final stream in manifest.audioOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }
      audioList.add(Aud.fromStreamInfo(stream));
    }
    return (video: videoList, audio: audioList);
  }
}
