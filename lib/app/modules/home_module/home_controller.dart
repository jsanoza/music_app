import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:music_app/app/data/model/rank_artists_model.dart';
import 'package:music_app/app/data/model/yt_related_suggestions_model.dart' as ytRelated;
import 'package:music_app/app/data/provider/home_provider.dart';
import 'package:music_app/app/data/provider/player_provider.dart';
import 'package:music_app/app/modules/player_module/player_controller.dart';
import 'package:music_app/app/themes/app_text_theme.dart';
import 'package:music_app/app/utils/widgets/app_divider/app_divider.dart';
import 'package:we_slide/we_slide.dart';
import '../../data/model/rank_albums_model.dart';
import '../../data/model/rank_tracks_model.dart';
import '../../data/model/spot_new_release_albums.dart';
import '../../data/model/video_model.dart';
import '../../utils/common.dart';
import '../../utils/widgets/bottom_sheet_provider/bottom_sheet_provider.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class HomeController extends GetxController {
  HomeController({this.provider});
  final HomeProvider? provider;
  WeSlideController slideController = WeSlideController();
  TextEditingController textController = TextEditingController();
  late BuildContext context;
  var isHidePanel = true.obs;
  var isHideBottom = false.obs;
  var isFetchingTopArtists = false.obs;
  var isFetchingTopAlbums = false.obs;
  var isFetchingTopTracks = false.obs;
  var isFetchingSpotify = false.obs;
  var isInitialLoad = true.obs;

  List<VideoItem> trendingMusicFromYT = <VideoItem>[].obs;
  List<VideoItem> singleMusic = <VideoItem>[].obs;
  var rankArtists = RankArtists().obs;
  var rankAlbums = RankAlbums().obs;
  var rankTracks = RankTracks().obs;
  var rankReleases = SpotAlbumReleases().obs;
  var selected = 0.obs;
  final player = AudioPlayer();
  var isOpened = <int>[].obs;

  var canVibrate = false.obs;

  @override
  void onInit() {
    super.onInit();
    // getTopArtists();
    // getTopArtists();

    fetchData();
    slideController.addListener(() {
      if (slideController.isOpened) {
        isHideBottom.value = true;
      } else {
        isHideBottom.value = false;
      }
    });
  }

  vibrate() async {
    if (canVibrate.value) Vibrate.feedback(FeedbackType.success);
  }

  Future<void> fetchData() async {
    canVibrate.value = await Vibrate.canVibrate;
    List<Future> futures = [
      getTopTracks(),
      getTopAlbums(),
      getSpotifyTop(),
      getTrendingMusicYT(),
    ];
    await Future.wait(futures).then((value) {
      isInitialLoad.value = false;
    });
  }

  checkAlbum(itemID, imageUrl, title) async {
    isOpened.clear();
    final response = await provider!.getAccessToken();
    final rec = await provider!.getAlbumTracks(response, itemID.toString());
    var previewAvailable = true.obs;

    BottomSheetProvider.showBottomSheetWithHeader(
      callback: () {
        player.stop();
        Get.find<PlayerController>().flickManager.flickControlManager!.play();
        Get.back();
      },
      content: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            expandedHeight: 400,
            automaticallyImplyLeading: false,
            pinned: true,
            stretch: true,
            floating: true,
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  stretchModes: [
                    StretchMode.zoomBackground,
                  ],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        height: 220,
                        width: 220,
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.5],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                imageUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                            child: Text(
                              "Track list",
                              style: AppTextStyles.base.blackColor.s24,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              List<String> title = <String>[].obs;
                              List<String> artist = <String>[].obs;
                              List<String> image = <String>[].obs;
                              rec.items!.forEach((element) {
                                title.add(element.name.toString());
                                artist.add(element.artists!.first.name.toString());
                                image.add(imageUrl);
                              });
                              playAlbumFromSpotify(title, artist, image, 0);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0, top: 16, bottom: 16),
                              child: Icon(LucideIcons.playCircle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        player.stop();

                        player.setUrl(rec.items![index].previewUrl.toString()).onError((error, stackTrace) {
                          log(error.toString());
                          previewAvailable.value = false;
                        });

                        isOpened.clear();
                        isOpened.add(index);
                        Future.delayed(Duration(milliseconds: 400), () {
                          player.play();
                          Get.find<PlayerController>().flickManager.flickControlManager!.pause();
                        });
                      },
                      trailing: Icon(
                        LucideIcons.moreVertical,
                        color: Colors.black,
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 12,
                          child: Text(
                            "${index + 1}",
                            style: AppTextStyles.base.whiteColor,
                          ),
                        ),
                      ),
                      title: Text(
                        rec.items![index].name.toString(),
                        style: AppTextStyles.base.w700.blackColor,
                      ),
                      subtitle: rec.items![index].artists!.length > 1 ? Text("Feat. ${rec.items![index].artists!.last.name.toString()}") : Text("${rec.items![index].artists!.first.name.toString()}"),
                    ),
                    Obx(
                      () => isOpened.contains(index)
                          ? Container(
                              height: 150,
                              width: Get.width,
                              child: Column(
                                children: [
                                  AppDivider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16.0, top: 16),
                                        child: Text("Preview"),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => previewAvailable.value == true
                                        ? Row(
                                            children: [
                                              SizedBox(
                                                child: StreamBuilder<PlayerState>(
                                                  stream: player.playerStateStream,
                                                  builder: (context, snapshot) {
                                                    final playerState = snapshot.data;
                                                    final processingState = playerState?.processingState;
                                                    final playing = playerState?.playing;

                                                    if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                                                      return Container(
                                                        margin: const EdgeInsets.all(8.0),
                                                        width: 30.0,
                                                        height: 30.0,
                                                        child: const CircularProgressIndicator(),
                                                      );
                                                    } else if (playing != true) {
                                                      return IconButton(
                                                        icon: const Icon(Icons.play_arrow),
                                                        iconSize: 30.0,
                                                        onPressed: player.play,
                                                      );
                                                    } else if (processingState != ProcessingState.completed) {
                                                      return IconButton(
                                                        icon: const Icon(Icons.pause),
                                                        iconSize: 30.0,
                                                        onPressed: player.pause,
                                                      );
                                                    } else {
                                                      return IconButton(
                                                        icon: const Icon(Icons.replay),
                                                        iconSize: 30.0,
                                                        onPressed: () => player.seek(Duration.zero),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: Get.width,
                                                  height: 30,
                                                  child: !player.playerState.playing
                                                      ? StreamBuilder<Duration>(
                                                          stream: player.positionStream,
                                                          builder: (context, snapshot) {
                                                            if (!snapshot.hasData || player.duration == null) {
                                                              return LinearProgressIndicator();
                                                            } else {
                                                              final progress = snapshot.data!.inMilliseconds / player.duration!.inMilliseconds;
                                                              return LinearProgressIndicator(
                                                                value: progress,
                                                              );
                                                            }
                                                          },
                                                        )
                                                      : SizedBox.shrink(),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 28,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                                                child: Text("No preview available."),
                                              ),
                                            ],
                                          ),
                                  ),
                                  AppDivider(),
                                  SizedBox(
                                    height: 28,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                );
              },
              childCount: rec.items!.length,
            ),
          ),
        ],
      ),
      title: title,
      context: context,
      maxHeight: Get.height - 110,
      padding: EdgeInsets.zero,
    );
  }

  bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (_) {
      return false;
    }
  }

  playTrendingFromYT(int index, String type) async {
    log(index.toString());
    isHidePanel.value = false;
    Get.put(PlayerController(provider: PlayerProvider()));
    List<VideoItem> listHandler = <VideoItem>[].obs;
    listHandler.addAll(trendingMusicFromYT);
    if (Get.find<PlayerController>().isInit.value == true) {
      Get.find<PlayerController>().handleChange(
        index: index,
        videoList2: listHandler,
      );
    } else {
      Get.find<PlayerController>().initPlayer(index, listHandler);
    }
  }

  playAlbumFromSpotify(List<String> title, List<String> artist, List<String> image, index) async {
    Get.put(PlayerController(provider: PlayerProvider()));
    List<VideoItem> albumList = <VideoItem>[].obs;
    var length = title.length < 15 ? title.length : 15;
    var futures = <Future>[];
    Common.showLoading();
    for (var i = 0; i < length; i++) {
      var future = provider!.getID(title[i], artist[i]).then((response) async {
        var value = await provider!.fetchUrls(response.externalId.toString());
        var item = VideoItem(
          artist: artist[i],
          image: image[i],
          title: title[i],
          trailerUrl: value,
          videoId: response.externalId.toString(),
        );
        albumList.add(item);

        if (i == 1) {
          player.stop();
          isOpened.clear();
        }

        isHidePanel.value = false;
        // Get.find<PlayerController>().playPause();
        List<VideoItem> handler = <VideoItem>[].obs;
        handler.addAll(albumList);
        if (Get.find<PlayerController>().isInit.value) {
          Get.find<PlayerController>().handleChange(
            index: index,
            videoList2: handler,
          );
          log("I'm here not init");
        } else {
          log("I'm here");
          Get.find<PlayerController>().initPlayer(index, albumList);
        }
      });
      futures.add(future);
    }

    await Future.wait(futures).whenComplete(() => Get.close(2));
  }

  searchFromSpotify(String title, String artist, String image, String youtubeID) async {
    Get.put(PlayerController(provider: PlayerProvider()));

    var response = await provider!.getID(title, artist);
    log(response.externalId.toString());
    singleMusic.clear();
    await provider!.fetchUrls(response.externalId.toString()).then((value) {
      var item = VideoItem(
        artist: artist,
        image: image,
        title: title,
        trailerUrl: value,
        videoId: response.externalId.toString(),
      );
      isHidePanel.value = false;
      singleMusic.add(item);

      if (Get.find<PlayerController>().isInit.value == true) {
        Get.find<PlayerController>().handleChange(
          index: 0,
          videoList2: singleMusic,
        );
      } else {
        Get.find<PlayerController>().initPlayer(0, singleMusic);
      }
    });
  }

  getTrendingMusicYT() async {
    var trendingHolder = await provider!.fetchTrending();
    trendingHolder.forEach((element) async {
      var url = await provider!.fetchUrls(element.videoId.toString());
      var item = VideoItem(
        artist: element.channelName!,
        image: element.thumbnails!.first.url!,
        title: element.title!,
        trailerUrl: url,
        videoId: element.videoId.toString(),
      );
      trendingMusicFromYT.add(item);
    });
  }

  getSpotifyTop() async {
    isFetchingSpotify.value = true;
    final response = await provider!.getAccessToken();
    final rec = await provider!.getTopTracks(response);
    updateSpotifyNewReleases(rec);
  }

  getTopArtists() async {
    isFetchingTopArtists.value = true;
    var response = await provider!.getArtistsRank();
    updateRankArtists(response);
  }

  getTopAlbums() async {
    isFetchingTopAlbums.value = true;
    var response = await provider!.getAlbumsRank();
    updateRankAlbums(response);
    log(response.toString());
  }

  getTopTracks() async {
    isFetchingTopTracks.value = true;
    var response = await provider!.getTrackRank();
    updateRankTracks(response);
    log(response.toString());
  }

  void updateRankArtists(RankArtists newRankArtists) {
    rankArtists.value = newRankArtists;
    isFetchingTopArtists.value = false;
  }

  void updateRankAlbums(RankAlbums newRankAlbums) {
    rankAlbums.value = newRankAlbums;
    isFetchingTopAlbums.value = false;
  }

  void updateRankTracks(RankTracks newRankTracks) {
    rankTracks.value = newRankTracks;
    isFetchingTopTracks.value = false;
  }

  void updateSpotifyNewReleases(SpotAlbumReleases newReleases) {
    rankReleases.value = newReleases;
    isFetchingSpotify.value = false;
  }
}
