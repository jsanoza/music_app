import 'package:get/get.dart';

class EndPoints {
  const EndPoints._();

  static var baseUrl = 'https://musicapi13.p.rapidapi.com/';

  static const Map<String, String> headers = {
    'content-type': 'application/json',
    'X-RapidAPI-Key': '6a3da1e732mshf1576b1251c9089p18bf2bjsn09ad580c1e24',
    'X-RapidAPI-Host': 'musicapi13.p.rapidapi.com',
  };

  static const Map<String, String> rankHeaders = {
    'X-RapidAPI-Key': 'ab4e70885emshac0d70ce622d3f1p12faf0jsn9ecc7299eb49',
    'X-RapidAPI-Host': 'spotify-scraper.p.rapidapi.com',
  };

  static const Map<String, String> suggestedVideos = {
    'content-type': 'application/octet-stream',
    'X-RapidAPI-Key': 'ab4e70885emshac0d70ce622d3f1p12faf0jsn9ecc7299eb49',
    'X-RapidAPI-Host': 'youtube-v31.p.rapidapi.com',
  };

  static const String clientId = '389c22dd6dd845f58ca540770ef884af';
  static const String clientSecret = 'f5e456832091432881fd4036d3efb930';

  static const String login = "auth/login";
  static const String search = "public/search";
  static const String topArtists = "top";
  static const String topAlbums = "albums/top";
  static const String topDailyViral = "tracks/viral";
  static const String topTracks = "tracks/top";

  static const Duration timeout = Duration(seconds: 30);

  static const String token = 'authToken';

  static const String errorPlaceHolderUrl = "https://zerojackerzz.com/wp-content/uploads/2019/10/album-placeholder.png";
}

enum LoadDataState { initialize, loading, loaded, error, timeout, unknownerror }
