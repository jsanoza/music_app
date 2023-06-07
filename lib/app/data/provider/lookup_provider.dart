import 'package:get/get.dart';
import 'package:music_app/app/data/api/api_connect.dart';
import 'package:music_app/app/data/model/user.dart';
import 'package:music_app/app/utils/constants.dart';
import 'package:youtube_data_api/models/channel.dart';
import 'package:youtube_data_api/models/playlist.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class LookupProvider {
  LookupProvider();

  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  yt.YoutubeExplode ytExplode = yt.YoutubeExplode();

  Future<List<Video>> fetchSearchResults(String searchString) async {
    List<Video> results = <Video>[];
    List videoResult = await youtubeDataApi.fetchSearchVideo(searchString, "");

    videoResult.forEach((element) {
      if (element != null) {
        if (element is Video) {
          results.add(element);
        }
      }
    });
    return results;
  }

  Future<String> fetchUrls(ids) async {
    var manifest = await ytExplode.videos.streamsClient.getManifest(ids);
    var streamInfo = manifest.muxed.withHighestBitrate();
    return streamInfo.url.toString();
  }
}
