import 'package:infinity_youtube/core/services/audio_source_model.dart';
import 'package:infinity_youtube/core/services/video_source_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

typedef YouTubeSource = ({
List<VideoSourceModel> video,
List<AudioSourceModel> audio,
});

class YoutubeParser {
  // --------------------------------------------------------------------------

  /// INSTANCE

  // --------------------
  final YoutubeExplode explode = YoutubeExplode();
  // --------------------
  void dispose(){
    explode.close();
  }
  // --------------------------------------------------------------------------

  /// PARSER

  // --------------------
  Future<YouTubeSource> parse(String url) async {

    final StreamManifest manifest = await explode.videos.streams.getManifest(url);

    final List<VideoSourceModel> videoList = <VideoSourceModel>[];
    final List<AudioSourceModel> audioList = <AudioSourceModel>[];

    /// LOOP VIDEOS
    for (final stream in manifest.videoOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }
      videoList.add(VideoSourceModel.fromStreamInfo(stream));
    }

    /// LOOP AUDIOS
    for (final stream in manifest.audioOnly) {
      if (stream.container != StreamContainer.mp4) {
        continue;
      }
      audioList.add(AudioSourceModel.fromStreamInfo(stream));
    }

    return (video: videoList, audio: audioList);
  }
  // --------------------------------------------------------------------------
}
