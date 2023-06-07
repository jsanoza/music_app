import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:easy_scroll_animation/easy_scroll_animation.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/app/data/provider/lookup_provider.dart';
import 'package:music_app/app/modules/home_module/home_controller.dart';
import 'package:music_app/app/modules/home_module/sample.dart';
import 'package:music_app/app/modules/lookup_module/lookup_controller.dart';
import 'package:music_app/app/themes/app_colors.dart';
import 'package:music_app/app/themes/app_text_theme.dart';
import 'package:music_app/app/utils/widgets/app_button/app_button.dart';
import 'package:music_app/app/utils/widgets/app_text_field/app_text_field.dart';
import 'package:rive/rive.dart' as riv;
import 'package:search_bar_animated/search_bar_animated.dart';
import 'package:video_player/video_player.dart';
import 'package:we_slide/we_slide.dart';

import '../../routes/app_pages.dart';
import '../../utils/loading.dart';
import '../../utils/widgets/app_bar/custom_app_bar.dart';
import '../player_module/player_controller.dart';
import '../player_module/player_page.dart';

import 'package:shimmer/shimmer.dart';

class HomePage extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      body: Obx(
        () => WeSlide(
            controller: controller.slideController,
            panelMinSize: controller.isHidePanel.value == true ? 0 : 100,
            panelMaxSize: Get.height,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColors.black,
                  expandedHeight: 50.0,
                  collapsedHeight: 80,
                  toolbarHeight: 80,
                  centerTitle: true,
                  flexibleSpace: SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Play",
                            style: AppTextStyles.base.whiteColor.s24,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.vibrate();
                              Get.toNamed(AppRoutes.lookup);
                            },
                            child: Icon(
                              LucideIcons.search,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: 50.0,
                  pinned: true,
                  title: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.put(LookupController(provider: LookupProvider()));
                            Get.find<LookupController>().searchText.value = "Relax";
                            Get.find<LookupController>().textEditingController.text = "Relax";
                            Get.find<LookupController>().search("Relax");
                            Get.toNamed(AppRoutes.lookup);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gray,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Relax", style: AppTextStyles.base.w400.s18.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.put(LookupController(provider: LookupProvider()));
                            Get.find<LookupController>().searchText.value = "Chill";
                            Get.find<LookupController>().textEditingController.text = "Chill";
                            Get.find<LookupController>().search("Chill");
                            Get.toNamed(AppRoutes.lookup);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gray,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Chill", style: AppTextStyles.base.w400.s18.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.put(LookupController(provider: LookupProvider()));
                            Get.find<LookupController>().searchText.value = "OPM";
                            Get.find<LookupController>().textEditingController.text = "OPM";
                            Get.find<LookupController>().search("OPM");
                            Get.toNamed(AppRoutes.lookup);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gray,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("OPM", style: AppTextStyles.base.w400.s18.whiteColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.put(LookupController(provider: LookupProvider()));
                            Get.find<LookupController>().searchText.value = "KPOP";
                            Get.find<LookupController>().textEditingController.text = "KPOP";
                            Get.find<LookupController>().search("KPOP");
                            Get.toNamed(AppRoutes.lookup);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.gray,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("KPOP", style: AppTextStyles.base.w400.s18.whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // Obx(
                      //   () => controller.isInitialLoad.value == false
                      //       ? Row(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 16.0, top: 8),
                      //               child: Text(
                      //                 controller.rankTracks.value.title.toString(),
                      //                 style: AppTextStyles.base.s18.whiteColor.w700,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 8.0),
                      //               child: Icon(
                      //                 LucideIcons.trendingUp,
                      //                 color: Colors.white,
                      //                 size: 8,
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : ShimmerContainer(
                      //           height: 20,
                      //         ),
                      // ),
                      // Obx(
                      //   () => controller.isInitialLoad.value == false
                      //       ? Row(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(left: 16.0, top: 0),
                      //               child: Text(
                      //                 controller.rankTracks.value.description.toString(),
                      //                 style: AppTextStyles.base.s12.whiteColor.w200,
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : ShimmerContainer(
                      //           height: 20,
                      //         ),
                      // ),
                      // Container(
                      //   height: 300,
                      //   width: Get.width,
                      //   child: Obx(() => controller.isFetchingTopTracks.value != true
                      //       ? ListView.builder(
                      //           scrollDirection: Axis.horizontal,
                      //           itemCount: 10,
                      //           itemBuilder: ((context, index) {
                      //             return InkWell(
                      //               onTap: () {
                      //                 controller.vibrate();
                      //                 controller.searchFromSpotify(
                      //                   controller.rankTracks.value.tracks![index].name.toString(),
                      //                   controller.rankTracks.value.tracks![index].artists!.first.name.toString(),
                      //                   controller.rankTracks.value.tracks![index].album!.cover!.first.url.toString(),
                      //                   controller.rankTracks.value.tracks![index].id.toString(),
                      //                 );
                      //               },
                      //               child: Padding(
                      //                 padding: const EdgeInsets.only(top: 18.0, right: 10, left: 10),
                      //                 child: Column(
                      //                   children: [
                      //                     Container(
                      //                       height: 200,
                      //                       width: 200,
                      //                       decoration: BoxDecoration(
                      //                         borderRadius: BorderRadius.circular(8.0),
                      //                         image: DecorationImage(
                      //                           fit: BoxFit.cover,
                      //                           image: NetworkImage(controller.rankTracks.value.tracks![index].album!.cover!.first.url.toString()),
                      //                         ),
                      //                       ),
                      //                       foregroundDecoration: const BoxDecoration(
                      //                         gradient: LinearGradient(
                      //                           colors: [
                      //                             Colors.black,
                      //                             Colors.transparent,
                      //                           ],
                      //                           begin: Alignment.bottomCenter,
                      //                           end: Alignment.topCenter,
                      //                           stops: [0, 0.5],
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Container(
                      //                       width: 200,
                      //                       child: Padding(
                      //                         padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      //                         child: Text(
                      //                           controller.rankTracks.value.tracks![index].name.toString(),
                      //                           style: AppTextStyles.base.whiteColor,
                      //                           overflow: TextOverflow.ellipsis,
                      //                           textAlign: TextAlign.center,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.only(left: 8.0, right: 8),
                      //                       child: Text(
                      //                         controller.rankTracks.value.tracks![index].artists!.first.name.toString(),
                      //                         style: AppTextStyles.base.whiteColor.s12,
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           }),
                      //         )
                      //       : Shimmer.fromColors(
                      //           baseColor: Colors.grey[300]!,
                      //           highlightColor: Colors.grey[100]!,
                      //           child: ListView.builder(
                      //             scrollDirection: Axis.horizontal,
                      //             itemCount: 10,
                      //             itemBuilder: ((context, index) {
                      //               return InkWell(
                      //                 onTap: () {},
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(top: 18.0, right: 10, left: 10),
                      //                   child: Column(
                      //                     children: [
                      //                       Container(
                      //                         height: 220,
                      //                         width: 200,
                      //                         decoration: BoxDecoration(
                      //                           borderRadius: BorderRadius.circular(8.0),
                      //                           color: Theme.of(context).splashColor,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               );
                      //             }),
                      //           ),
                      //         )),
                      // ),
                      Container(
                        width: Get.width,
                        child: Column(
                          children: [
                            Obx(
                              () => controller.isInitialLoad.value == false
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0, top: 8),
                                          child: Text(
                                            "New Album Releases",
                                            style: AppTextStyles.base.s18.whiteColor.w700,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            LucideIcons.trendingUp,
                                            color: Colors.white,
                                            size: 8,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ShimmerContainer(
                                      height: 20,
                                    ),
                            ),
                            Obx(
                              () => controller.isInitialLoad == false
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0, top: 0),
                                          child: Text(
                                            "Your weekly update of the latest album releases.",
                                            style: AppTextStyles.base.s12.whiteColor.w200,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ShimmerContainer(
                                      height: 20,
                                    ),
                            ),
                            Container(
                              height: 200,
                              width: Get.width,
                              child: Obx(() => controller.isFetchingSpotify.value != true
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 10,
                                      padding: EdgeInsets.zero,
                                      cacheExtent: 9999,
                                      itemBuilder: ((context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.vibrate();
                                            controller.checkAlbum(
                                              controller.rankReleases.value.albums!.items![index].id,
                                              controller.rankReleases.value.albums!.items![index].images!.first.url.toString(),
                                              controller.rankReleases.value.albums!.items![index].name.toString(),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 18.0, left: 12),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.white,
                                                    ),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        controller.rankReleases.value.albums!.items![index].images!.first.url.toString(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                                                  child: Container(
                                                    width: 80,
                                                    child: Center(
                                                      child: Text(
                                                        controller.rankReleases.value.albums!.items![index].name.toString(),
                                                        style: AppTextStyles.base.whiteColor,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                                                  child: Container(
                                                    width: 100,
                                                    child: Center(
                                                      child: Text(
                                                        controller.rankReleases.value.albums!.items![index].artists!.first.name.toString(),
                                                        style: AppTextStyles.base.neutral3Color.s12,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 10,
                                        padding: EdgeInsets.zero,
                                        cacheExtent: 9999,
                                        itemBuilder: ((context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.vibrate();
                                              controller.checkAlbum(
                                                controller.rankReleases.value.albums!.items![index].id,
                                                controller.rankReleases.value.albums!.items![index].images!.first.url.toString(),
                                                controller.rankReleases.value.albums!.items![index].name.toString(),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 18.0, left: 12),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).splashColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    )),
                            ),
                            Obx(
                              () => controller.isInitialLoad.value == false
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 16.0, top: 0),
                                          child: Text(
                                            "Weekly Trending Songs",
                                            style: AppTextStyles.base.s18.whiteColor.w700,
                                          ),
                                        ),
                                      ],
                                    )
                                  : ShimmerContainer(height: 20),
                            ),
                            Container(
                              height: 300,
                              width: Get.width,
                              child: GridView.builder(
                                cacheExtent: 9999,
                                padding: EdgeInsets.zero,
                                physics: const PageScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: .2,
                                ),
                                itemCount: controller.trendingMusicFromYT.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return DelayedWidget(
                                    delayDuration: Duration(milliseconds: 400),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: ListTile(
                                          onTap: () {
                                            controller.vibrate();
                                            controller.playTrendingFromYT(index, "Trending");
                                          },
                                          dense: true,
                                          leading: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.0),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    controller.trendingMusicFromYT[index].image.toString(),
                                                  ),
                                                )),
                                            height: 50,
                                            width: 50,
                                          ),
                                          subtitle: Text(
                                            controller.trendingMusicFromYT[index].artist.toString(),
                                            style: AppTextStyles.base.whiteColor.s10,
                                          ),
                                          title: Text(
                                            controller.trendingMusicFromYT[index].title.toString(),
                                            style: AppTextStyles.base.whiteColor.s10,
                                          ),
                                          trailing: Icon(
                                            LucideIcons.moreVertical,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                                        child: Text(
                                          controller.rankAlbums.value.title.toString(),
                                          style: AppTextStyles.base.s18.whiteColor.w700,
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        LucideIcons.trendingUp,
                                        color: Colors.white,
                                        size: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16.0, top: 0),
                                      child: Text(
                                        controller.rankAlbums.value.description.toString(),
                                        style: AppTextStyles.base.s12.whiteColor.w200,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 800,
                              width: Get.width,
                              child: Obx(
                                () => controller.isFetchingTopAlbums.value != true
                                    ? Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 16),
                                        child: GridView.builder(
                                          cacheExtent: 9999,
                                          padding: EdgeInsets.zero,
                                          physics: const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 120,
                                            childAspectRatio: 3 / 6,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                          ),
                                          itemCount: 9,
                                          itemBuilder: ((context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.vibrate();
                                                log(controller.rankAlbums.value.albums![index].id.toString());
                                                log(controller.rankAlbums.value.albums![index].cover!.first.url.toString());
                                                log(controller.rankAlbums.value.albums![index].name.toString());
                                                controller.checkAlbum(
                                                  controller.rankAlbums.value.albums![index].id.toString(),
                                                  controller.rankAlbums.value.albums![index].cover!.first.url.toString(),
                                                  controller.rankAlbums.value.albums![index].name.toString(),
                                                );
                                                // controller.checkAlbum(controller.rankAlbums.value.albums[index]);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(top: 0.0, right: 0),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 100,
                                                        width: 100,
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
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                controller.rankAlbums.value.albums![index].cover!.first.url.toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        controller.rankAlbums.value.albums![index].name.toString(),
                                                        style: AppTextStyles.base.whiteColor,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      )
                                    : Loading(
                                        loadingType: LoadingType.chasingDots,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            panel: Get.isRegistered<PlayerController>() ? PlayerPage() : SizedBox.shrink(),
            panelHeader: Get.isRegistered<PlayerController>()
                ? SafeArea(
                    bottom: true,
                    top: false,
                    child: Container(
                      height: 80,
                      color: Colors.black,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        isThreeLine: true,
                        dense: true,
                        leading: Obx(() => Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
                              child: Image.network(
                                Get.find<PlayerController>().image.toString(),
                                fit: BoxFit.cover,
                              ),
                            )),
                        subtitle: Text(
                          Get.find<PlayerController>().artist.toString(),
                          style: AppTextStyles.base.whiteColor.s10,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            height: 20,
                            width: Get.width / 2,
                            child: Marquee(
                              text: Get.find<PlayerController>().title.toString(),
                              style: AppTextStyles.base.whiteColor.s12,
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
                        trailing: Container(
                          height: 110,
                          width: 90,
                          child: GestureDetector(
                            onTap: () {
                              controller.vibrate();
                              Get.find<PlayerController>().playPause();
                            },
                            child: riv.Rive(
                              artboard: Get.find<PlayerController>().birdArtboard,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink()),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, top: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: Get.width,
          color: Theme.of(context).splashColor,
        ),
      ),
    );
  }
}
