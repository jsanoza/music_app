import 'dart:developer';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:music_app/app/data/api/api_connect.dart';
import 'package:http/http.dart' as http;

class PlayerProvider {
  PlayerProvider();
  ApiConnect api = ApiConnect.instance;
  yt.YoutubeExplode ytExplode = yt.YoutubeExplode();

  Future<String> fetchUrls(ids) async {
    var manifest = await ytExplode.videos.streamsClient.getManifest(ids);
    var streamInfo = manifest.muxed.withHighestBitrate();
    return streamInfo.url.toString();
  }

}
