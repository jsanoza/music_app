import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_data_api/models/video.dart';
import '../../../app/data/provider/lookup_provider.dart';
import '../../data/model/video_model.dart';
import '../../data/provider/player_provider.dart';
import '../home_module/home_controller.dart';
import '../player_module/player_controller.dart';

class LookupController extends GetxController {
  final LookupProvider? provider;
  LookupController({this.provider});
  final _box = GetStorage();

  TextEditingController textEditingController = TextEditingController();
  @override
  void onInit() {
    initStorage();
    super.onInit();
  }

  var showHistory = true.obs;
  var isSearching = true.obs;

  List<String> items = <String>[].obs;
  List<Video> resultsList = <Video>[].obs;
  List<VideoItem> list = <VideoItem>[].obs;
  final RxString searchText = ''.obs;

  initStorage() async {
    await _box.writeIfNull('searchList', []);
    var history = await _box.read('searchList');
    if (history != null) {
      items = history;
    }
  }

  List<String> getFilteredItems() {
    if (searchText.value.isEmpty) {
      return items;
    } else {
      return items.where((item) => item.toLowerCase().contains(searchText.value.toLowerCase())).toList();
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }

  search(String text) async {
    showHistory.value = false;
    resultsList.clear();
    await _box.remove("searchList");
    if (!items.contains(text)) {
      items.add(text);
    }
    await _box.writeIfNull('searchList', items);
    resultsList = await provider!.fetchSearchResults(text);

    isSearching.value = true;
    list.clear();
  }

  play(Video video) async {
    var value = await provider!.fetchUrls(video.videoId.toString());
    var item = VideoItem(
      artist: video.channelName!,
      image: video.thumbnails!.first.url!,
      title: video.title!,
      trailerUrl: value,
      videoId: video.videoId.toString(),
    );

    list.add(item);
    resultsList.clear();
    Get.back();
    Get.put(PlayerController(provider: PlayerProvider()));
    Get.find<HomeController>().isHidePanel.value = false;
    if (Get.find<PlayerController>().isInit.value == true) {
      Get.find<PlayerController>().handleChange(
        index: 0,
        videoList2: list,
      );
    } else {
      Get.find<PlayerController>().initPlayer(0, list);
    }
  }
}
