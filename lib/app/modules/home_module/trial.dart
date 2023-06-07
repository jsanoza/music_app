import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:flick_video_player/flick_video_player.dart';
import '../../data/model/video_model.dart';

class FlickVideoPlayerWidget extends StatefulWidget {
  @override
  _FlickVideoPlayerWidgetState createState() => _FlickVideoPlayerWidgetState();
}

class _FlickVideoPlayerWidgetState extends State<FlickVideoPlayerWidget> {
  FlickManager? flickManager;
  List<VideoItem> videoList = [
    VideoItem(title: 'Video 1', trailerUrl: 'https://joy1.videvo.net/videvo_files/video/free/2015-09/large_watermarked/keyboard_stock_preview.mp4', artist: '', image: '', videoId: ''),
  ]; // Replace with your video list

  @override
  void initState() {
    super.initState();
    initializeFlickManager();
  }

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  void initializeFlickManager() {
    if (videoList.isNotEmpty) {
      final videoPlayerController = VideoPlayerController.network(videoList.first.trailerUrl);

      flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
      );

      videoPlayerController.initialize().then((_) {
        flickManager?.registerContext(Get.context!);
        setState(() {}); // Trigger a rebuild to show the video player
      });
    }
  }

  void updateVideoList() {
    // Replace with your logic to update the video list
    // For example:
    videoList = [
      VideoItem(title: 'Video 1', trailerUrl: 'https://joy1.videvo.net/videvo_files/video/free/2015-10/large_watermarked/Hacker_glasses_03_Videvo_preview.mp4', artist: '', image: '', videoId: ''),
      // Add more video items as per your requirement
    ];
    final videoPlayerController = VideoPlayerController.network(videoList.first.trailerUrl);
    flickManager!.handleChangeVideo(videoPlayerController);
    // f
    // flickManager?.flickControlManager?.dispose();
    // flickManager?.flickDisplayManager?.dispose();
    // flickManager?.flickVideoManager?.dispose();

    // initializeFlickManager();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (flickManager != null)
          FlickVideoPlayer(
            flickManager: flickManager!,
            flickVideoWithControls: FlickVideoWithControls(
              videoFit: BoxFit.contain,
            ),
            flickVideoWithControlsFullscreen: FlickVideoWithControls(
              backgroundColor: Colors.white,
              controls: FlickLandscapeControls(),
            ),
          ),
        ElevatedButton(
          onPressed: updateVideoList,
          child: Text('Update Video List'),
        ),
      ],
    );
  }
}
