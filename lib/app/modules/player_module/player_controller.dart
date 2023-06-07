import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genius_lyrics/genius_lyrics.dart';
import 'package:get/get.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';
import 'package:rive/rive.dart';
import 'package:video_player/video_player.dart';
import 'package:we_slide/we_slide.dart';
import '../../../app/data/provider/player_provider.dart';
import '../../data/api/lyrics_service.dart';
import '../../data/model/video_model.dart';

class PlayerController extends GetxController {
  final PlayerProvider? provider;
  PlayerController({this.provider});
  Genius genius = Genius(accessToken: "cMuDxpYJY88uy_Vcay0WSUQGBqG42Yb5a_IGbCm_H5tqUpiBrD7ldw6QVuyWL6Rp");
  List<VideoItem> videos = <VideoItem>[].obs;
  List<VideoItem> upNext = <VideoItem>[].obs;
  List<VideoItem> recommendedVideos = <VideoItem>[].obs;
  // final videoList = VideoList.fromJson(jsonDecode(mockData));
  late BuildContext context;
  late FlickManager flickManager;
  late AnimationPlayerDataManager dataManager;
  var _progressValue = 0.0.obs;
  var isPlaying = false.obs;
  var title = "".obs;
  var artist = "".obs;
  var image = "".obs;
  var isInit = false.obs;
  var songLyric = "".obs;
  var tabIndex = 0.obs;
  var currentIndex = 0.obs;

  late Artboard birdArtboard;
  SMIBool? trigger;
  StateMachineController? stateMachineController;
  WeSlideController slideController = WeSlideController();
  @override
  void onInit() {
    setUpRive();

    super.onInit();
  }

  playPause() async {
    if (flickManager.flickVideoManager!.isPlaying) {
      flickManager.flickControlManager!.pause();
      isPlaying.value = false;
      trigger?.change(false);
    } else {
      flickManager.flickControlManager!.play();
      isPlaying.value = true;
      trigger?.change(true);
    }
  }

  getLyrics({required String title, required String artist}) async {
    // Lyrics lyrics = Lyrics();
    
    try {
      log("im here");
      Song? song = await genius.searchSong(artist: artist, title: title);
      if (song != null) {
        songLyric.value = song.lyrics.toString();
        log(song.lyrics.toString());
      } else {
        log("hey!");
      }

      // songLyric.value = await lyrics.getLyrics(artist: artist, track: title);
      // songLyric.value = await provider!.fetchSongLyrics(title);
    } catch (e) {
      log(e.toString());
      songLyric.value = "No lyrics available";
    }
    log(songLyric.value.toString());
  }

  handleChange({required List<VideoItem> videoList2, required index, String? fromWhere}) async {
    if (fromWhere == null) {
      upNext.clear();
      upNext.addAll(videoList2);
    }

    final videoPlayerController = VideoPlayerController.network(
      videoList2[index].trailerUrl,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: true,
      ),
    );

    flickManager.handleChangeVideo(
      videoPlayerController,
    );

    dataManager = AnimationPlayerDataManager(flickManager, videoList2);

    playPause();

    title.value = videoList2[index].title;
    image.value = videoList2[index].image;
    artist.value = videoList2[index].artist;
    var id = videoList2[index].videoId;
    currentIndex.value = index;
    getLyrics(
      title: videoList2[index].title,
      artist: videoList2[index].artist,
    );
    getRecommendedVideos(id);
  }

  getRecommendedVideos(String youtubeID) async {
    recommendedVideos.clear();
    await Get.find<HomeController>().provider!.fetchRelated(youtubeID).then((value) async {
      log(value.toString());
      for (var element in value.items!) {
        var value = await provider!.fetchUrls(element.id.videoId.toString());
        if (element.snippet.thumbnails!.standardThumbnail.url != "") {
          var item = VideoItem(
            image: element.snippet.thumbnails!.standardThumbnail.url,
            title: element.snippet.title.toString(),
            artist: element.snippet.channelTitle.toString(),
            trailerUrl: value,
            videoId: element.id.videoId.toString(),
          );
          recommendedVideos.add(item);
        }
      }
    });
  }

  initPlayer(index, List<VideoItem> videoList) async {
    // videos.clear();
    final videoPlayerController = VideoPlayerController.network(
      videoList.first.trailerUrl,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: true,
      ),
    );
    flickManager = FlickManager(
      autoPlay: true,
      autoInitialize: true,
      videoPlayerController: videoPlayerController,
      onVideoEnd: () {
        _progressValue.value = 0.0;
        dataManager.playNextVideo(
          Duration(seconds: 5),
        );
        currentIndex.value = currentIndex.value++;
      },
    );

    videoPlayerController.initialize().then((_) {
      flickManager.registerContext(Get.context!);
    });

    dataManager = AnimationPlayerDataManager(flickManager, videoList);

    title.value = videoList.first.title;
    image.value = videoList.first.image;
    artist.value = videoList.first.artist;
    upNext = videoList;
    currentIndex.value = index;

    getLyrics(
      title: videoList.first.title,
      artist: videoList.first.artist,
    );
    recommendedVideos.clear();
    getRecommendedVideos(videoList.first.videoId);

    dataManager.playVideoAtIndex(index);

    playPause();
    flickManager.flickVideoManager!.addListener(() {
      if (flickManager.flickVideoManager!.videoPlayerValue!.position.inMilliseconds > 0 && flickManager.flickVideoManager!.videoPlayerValue!.duration.inMilliseconds > 0) {
        double progress = flickManager.flickVideoManager!.videoPlayerValue!.position.inMilliseconds / flickManager.flickVideoManager!.videoPlayerValue!.duration.inMilliseconds;
        _progressValue.value = progress;
        update();
      }
    });

    isInit.value = true;
  }

  setUpRive() async {
    rootBundle.load('assets/play_pause.riv').then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      stateMachineController = StateMachineController.fromArtboard(artboard, "State Machine 1");
      if (stateMachineController != null) {
        artboard.addController(stateMachineController!);
        stateMachineController!.inputs.forEach((e) {
          trigger = e as SMIBool;
        });
        trigger?.change(true);
      }
      birdArtboard = artboard;
      update();
    });
  }

  @override
  void onClose() {
    flickManager.dispose();
    super.onClose();
  }

  double get progressValue => _progressValue.value;
}

class AnimationPlayerDataManager {
  bool inAnimation = false;
  final FlickManager flickManager;
  List<VideoItem> items;
  int currentIndex = 0;
  late Timer videoChangeTimer;

  AnimationPlayerDataManager(this.flickManager, this.items);

  void updateCurrentIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < items.length) {
      currentIndex = newIndex;
      flickManager.handleChangeVideo(
        VideoPlayerController.network(items[currentIndex].trailerUrl),
        videoChangeDuration: null,
        timerCancelCallback: (_) {},
      );
    }
  }

  void updateVideoList(List<VideoItem> newItems) {
    items = newItems;
    currentIndex = 0;
  }

  playVideoAtIndex(int index, [Duration? duration]) {
    currentIndex = index;
    String videoUrl = items[currentIndex].trailerUrl;

    Get.find<PlayerController>().title.value = items[currentIndex].title;
    Get.find<PlayerController>().artist.value = items[currentIndex].artist;
    Get.find<PlayerController>().image.value = items[currentIndex].image;

    if (duration != null) {
      videoChangeTimer = Timer(duration, () {
        playNextVideo();
      });
    }

    flickManager.handleChangeVideo(VideoPlayerController.network(videoUrl), videoChangeDuration: duration, timerCancelCallback: (bool playNext) {
      videoChangeTimer.cancel();
      if (playNext) {
        playNextVideo();
      }
    });

    flickManager.flickControlManager!.play();
  }

  playPreviousVideo([Duration? duration]) {
    if (currentIndex <= 0) {
      currentIndex = items.length;
    }

    String previousVideoUrl = items[currentIndex - 1].trailerUrl;

    Get.find<PlayerController>().title.value = items[currentIndex - 1].title;
    Get.find<PlayerController>().artist.value = items[currentIndex - 1].artist;
    Get.find<PlayerController>().image.value = items[currentIndex - 1].image;

    if (currentIndex != 0) {
      if (duration != null) {
        videoChangeTimer = Timer(duration, () {
          currentIndex--;
        });
      } else {
        currentIndex--;
      }

      flickManager.handleChangeVideo(VideoPlayerController.network(previousVideoUrl), videoChangeDuration: duration, timerCancelCallback: (bool playPrevious) {
        videoChangeTimer.cancel();
        if (playPrevious) {
          currentIndex--;
        }
      });
      Get.find<PlayerController>().playPause();
    }
  }

  playNextVideo([Duration? duration]) {
    if (currentIndex >= items.length - 1) {
      currentIndex = -1;
    }

    String nextVideoUrl = items[currentIndex + 1].trailerUrl;
    Get.find<PlayerController>().title.value = items[currentIndex + 1].title;
    Get.find<PlayerController>().artist.value = items[currentIndex + 1].artist;
    Get.find<PlayerController>().image.value = items[currentIndex + 1].image;

    if (currentIndex != items.length - 1) {
      if (duration != null) {
        videoChangeTimer = Timer(duration, () {
          currentIndex++;
        });
      } else {
        currentIndex++;
      }

      flickManager.handleChangeVideo(VideoPlayerController.network(nextVideoUrl), videoChangeDuration: duration, timerCancelCallback: (bool playNext) {
        videoChangeTimer.cancel();
        if (playNext) {
          currentIndex++;
        }
      });
      Get.find<PlayerController>().playPause();
    }
  }

  String getCurrentVideoTitle() {
    if (currentIndex != -1) {
      return items[currentIndex].title;
    } else {
      return items[items.length - 1].title;
    }
  }

  String getNextVideoTitle() {
    if (currentIndex != items.length - 1) {
      return items[currentIndex + 1].title;
    } else {
      return items[0].title;
    }
  }

  String getCurrentPoster() {
    if (currentIndex != -1) {
      return items[currentIndex].image;
    } else {
      return items[items.length - 1].image;
    }
  }
}
