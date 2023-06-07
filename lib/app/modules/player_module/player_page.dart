import 'dart:developer';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/app/themes/app_colors.dart';
import 'package:music_app/app/themes/app_text_theme.dart';
import 'package:music_app/app/utils/widgets/bottom_sheet_provider/bottom_sheet_provider.dart';
import 'package:rive/rive.dart';
import '../../../app/modules/player_module/player_controller.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../../utils/constants.dart';

class PlayerPage extends GetWidget<PlayerController> {
  const PlayerPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: GestureDetector(
        onVerticalDragEnd: (details) {
          Options(context, controller.tabIndex.value);
        },
        onTap: () {
          Options(context, controller.tabIndex.value);
        },
        child: DelayedWidget(
          delayDuration: Duration(milliseconds: 2000),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                onTap: (index) {
                  controller.tabIndex.value = index;
                  Options(context, controller.tabIndex.value);
                },
                tabs: [
                  Tab(icon: Text("Up Next")),
                  Tab(icon: Text("Lyrics")),
                  Tab(icon: Text("Similar")),
                ],
              ),
            ),
            height: 100,
            width: Get.width,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              height: 100,
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      LucideIcons.chevronDown,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    "Play",
                    style: AppTextStyles.base.whiteColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      LucideIcons.moreVertical,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.playPause();
              },
              child: Container(
                height: Get.height / 4,
                color: Colors.red,
                child: FlickVideoPlayer(
                  flickManager: controller.flickManager,
                  flickVideoWithControls: FlickVideoWithControls(
                    videoFit: BoxFit.contain,
                  ),
                  flickVideoWithControlsFullscreen: FlickVideoWithControls(
                    backgroundColor: Colors.white,
                    controls: FlickLandscapeControls(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Obx(
              () => SizedBox(
                height: 30,
                width: Get.width / 2,
                child: Marquee(
                  text: controller.title.value,
                  style: AppTextStyles.base.whiteColor,
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 20.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 10.0,
                  accelerationDuration: Duration(seconds: 1),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
            ),
            Obx(
              () => Text(
                controller.artist.value.toString(),
                style: AppTextStyles.base.whiteColor.s12,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              final progressValue = controller.progressValue;
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: ProgressBar(
                  barHeight: 2,
                  thumbRadius: 5,
                  timeLabelTextStyle: AppTextStyles.base.whiteColor,
                  progress: Duration(milliseconds: controller.flickManager.flickVideoManager!.videoPlayerValue!.position.inMilliseconds),
                  total: Duration(milliseconds: controller.flickManager.flickVideoManager!.videoPlayerValue!.duration.inMilliseconds),
                  onSeek: (duration) {
                    controller.flickManager.flickControlManager!.seekTo(duration);
                    controller.flickManager.flickControlManager!.play();
                    controller.isPlaying.value = true;
                  },
                ),
              );
            }),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    LucideIcons.shuffle,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.dataManager.playPreviousVideo();
                    },
                    child: Icon(
                      LucideIcons.skipBack,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      height: 110,
                      width: 90,
                      child: GestureDetector(
                        onTap: () {
                          controller.playPause();
                        },
                        child: Rive(
                          artboard: controller.birdArtboard,
                        ),
                      )),
                  GestureDetector(
                    onTap: () {
                      log("replay");
                      controller.dataManager.playNextVideo();
                    },
                    child: Icon(
                      LucideIcons.skipForward,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.flickManager.flickControlManager!.replay();
                      log("replay");
                    },
                    child: Icon(
                      LucideIcons.repeat,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Options(BuildContext context, index) {
    BottomSheetProvider.showBottomSheetWithHeader(
      context: context,
      maxHeight: Get.height - 110,
      content: DefaultTabController(
        length: 3,
        initialIndex: index,
        child: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              TabBar(
                onTap: (index2) {
                  controller.tabIndex.value = index2;
                },
                tabs: [
                  Tab(icon: Text("Up Next")),
                  Tab(icon: Text("Lyrics")),
                  Tab(icon: Text("Similar")),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.white,
                    child: Obx(
                      () => ListView.builder(
                          itemCount: controller.upNext.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => Container(
                                color: controller.currentIndex.value == index ? Colors.grey.shade200 : Colors.white,
                                child: ListTile(
                                  onTap: () {
                                    controller.handleChange(
                                      fromWhere: "upNext",
                                      index: index,
                                      videoList2: controller.upNext,
                                    );
                                    // log(controller.recommendedVideos.toString());
                                  },
                                  trailing: Icon(
                                    LucideIcons.moreVertical,
                                    color: Colors.black,
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.network(
                                      controller.upNext[index].image.toString(),
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 70,
                                          child: Image.network(EndPoints.errorPlaceHolderUrl.toString()),
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    controller.upNext[index].title.toString(),
                                    style: AppTextStyles.base.w700.blackColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    controller.upNext[index].artist.toString(),
                                    style: AppTextStyles.base.w200.blackColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            child: Obx(() {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  controller.songLyric.value.toString(),
                                  style: AppTextStyles.base.blackColor,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.white,
                    child: Obx(
                      () => ListView.builder(
                          itemCount: controller.recommendedVideos.length,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => Container(
                                child: ListTile(
                                  onTap: () {
                                    controller.handleChange(
                                      index: index,
                                      videoList2: controller.recommendedVideos,
                                    );
                                  },
                                  trailing: Icon(
                                    LucideIcons.moreVertical,
                                    color: Colors.black,
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Image.network(
                                      controller.recommendedVideos[index].image.toString(),
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 70,
                                          child: Image.network(EndPoints.errorPlaceHolderUrl.toString()),
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    controller.recommendedVideos[index].title.toString(),
                                    style: AppTextStyles.base.w700.blackColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    controller.recommendedVideos[index].artist.toString(),
                                    style: AppTextStyles.base.w200.blackColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
