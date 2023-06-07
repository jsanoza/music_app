import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/app/data/api/api_connect.dart';
import 'package:music_app/app/data/model/rank_artists_model.dart';
import 'package:music_app/app/data/model/spot_album_tracks.dart';
import 'package:music_app/app/data/model/track_model.dart';
import 'package:music_app/app/data/model/user.dart';
import 'package:music_app/app/utils/constants.dart';
import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_data_api/youtube_data_api.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

import '../api/get_storage.dart';
import '../model/rank_albums_model.dart';
import '../model/rank_tracks_model.dart';
import '../model/spot_new_release_albums.dart';
import '../model/yt_related_suggestions_model.dart';

class HomeProvider {
  HomeProvider();

  ApiConnect api = ApiConnect.instance;
  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  yt.YoutubeExplode ytExplode = yt.YoutubeExplode();

  Future<List<String>> searchSuggestions(String query) async {
    List<String> suggestions = <String>[];
    await youtubeDataApi.fetchSuggestions(query).then((value) {
      suggestions = value;
    }).onError((error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
    });

    return suggestions;
  }

  Future<List<Video>> fetchTrending() async {
    List<Video> trendingMusic = <Video>[];

    await youtubeDataApi.fetchTrendingMusic().then((value) {
      trendingMusic = value;
    }).onError((error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
    });
    return trendingMusic;
  }

  Future<String> fetchUrls(ids) async {
    var manifest = await ytExplode.videos.streamsClient.getManifest(ids);
    var streamInfo = manifest.muxed.withHighestBitrate();
    return streamInfo.url.toString();
  }

  Future<TrackDetails> getID(String track, String artist) async {
    api.baseUrl = "https://musicapi13.p.rapidapi.com/";
    var trackModel;
    // EndPoints.baseUrl.value = "https://musicapi13.p.rapidapi.com/";
    final Map<String, dynamic> data = {
      'track': track,
      'artist': artist,
      'type': 'track',
      'sources': ['youtube'],
    };
    final response = await api.post(
      "https://musicapi13.p.rapidapi.com/" + EndPoints.search,
      data,
      headers: EndPoints.headers,
    );
    if (response.statusCode == 200) {
      var responseJson = response.body['tracks'][0]['data'];
      trackModel = TrackDetails.fromJson(responseJson);
    }

    return trackModel;
  }

  Future<RankArtists> getArtistsRank() async {
    if (GetStorage().hasData("topArtists")) {
      var topArtists = await GetStorage().read("topArtists");
      var rankArtists = RankArtists.fromJson(topArtists);
      return rankArtists;
    } else {
      final response = await api.get("https://spotify-scraper.p.rapidapi.com/v1/chart/artists/" + EndPoints.topArtists, headers: EndPoints.rankHeaders);
      var responseJson = response.body;
      var rankArtists = RankArtists.fromJson(responseJson);
      await GetStorage().writeIfNull('topArtists', responseJson);
      return rankArtists;
    }
  }

  Future<RankAlbums> getAlbumsRank() async {
    if (GetStorage().hasData("topAlbums")) {
      var topAlbums = await GetStorage().read("topAlbums");
      var rankAlbums = RankAlbums.fromJson(topAlbums);
      return rankAlbums;
    } else {
      final response = await api.get("https://spotify-scraper.p.rapidapi.com/v1/chart/" + EndPoints.topAlbums, headers: EndPoints.rankHeaders);
      var responseJson = response.body;
      var rankAlbums = RankAlbums.fromJson(responseJson);
      await GetStorage().writeIfNull('topAlbums', responseJson);
      return rankAlbums;
    }
  }

  Future<RankTracks> getTrackRank() async {
    final response = await api.get("https://spotify-scraper.p.rapidapi.com/v1/chart/" + EndPoints.topTracks, headers: EndPoints.rankHeaders);
    var responseJson = response.body;
    var rankTracks = RankTracks.fromJson(responseJson);
    await GetStorage().writeIfNull('topTracks', responseJson);
    log(rankTracks.toString());
    return rankTracks;
  }

  Future<String> getAccessToken() async {
    final credentials = base64.encode(utf8.encode('${EndPoints.clientId}:${EndPoints.clientSecret}'));
    final authorization = 'Basic $credentials';

    final Map<String, dynamic> data = {
      'grant_type': 'client_credentials',
    };
    final response = await api.post(
      'https://accounts.spotify.com/api/token',
      data,
      contentType: 'application/x-www-form-urlencoded',
      headers: {
        'Authorization': authorization,
      },
    );
    if (response.statusCode == 200) {
      final token = response.body['access_token'];
      log(token.toString());
      return token;
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<SpotAlbumReleases> getTopTracks(String token) async {
    final response = await api.get(
      'https://api.spotify.com/v1/browse/new-releases',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final trackModel = SpotAlbumReleases.fromJson(response.body);

      log(trackModel.albums!.items!.first.artists!.first.name.toString());

      return trackModel;
    } else {
      throw Exception('Failed to get top tracks');
    }
  }

  Future<SpotAlbumTracks> getAlbumTracks(String token, String albumID) async {
    final response = await api.get(
      "https://api.spotify.com/v1/albums/${albumID}/tracks",
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final trackModel = SpotAlbumTracks.fromJson(response.body);

      return trackModel;
    } else {
      throw Exception('Failed to get top tracks');
    }
  }

  Future<YouTubeSearchResponse> fetchRelated(String videoId) async {
    log(videoId.toString());

    final url = Uri.https('youtube-v31.p.rapidapi.com', '/search', {
      'relatedToVideoId': videoId,
      'part': 'id,snippet',
      'type': 'video',
      'maxResults': '50',
    });

    final response = await api.get(url.toString(), headers: EndPoints.suggestedVideos);
    var responseJson = response.body;
    // log(response.body.toString());
    var suggestedVideos = YouTubeSearchResponse.fromJson(responseJson);

    return suggestedVideos;
  }
}
