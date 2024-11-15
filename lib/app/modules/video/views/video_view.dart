import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/video_controller.dart';
import 'package:video_player/video_player.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Picker'),
        elevation: 4,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height / 2.32,
              width: Get.width * 0.7,
              child: Obx(() {
                if (controller.selectedVideoPath.value.isNotEmpty &&
                    controller.videoPlayerController != null) {
                  return Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: VideoPlayer(controller.videoPlayerController!),
                      ),
                      VideoProgressIndicator(
                        controller.videoPlayerController!,
                        allowScrubbing: true,
                      ),
                      IconButton(
                        icon: Icon(
                          controller.isVideoPlaying.isTrue
                              ? Icons.play_arrow
                              : Icons.pause,
                        ),
                        onPressed: controller.togglePlayPause,
                      ),
                    ],
                  );
                } else {
                  return const Text('No video selected');
                }
              }),
            ),
            ElevatedButton(
              onPressed: () => controller.pickVideo(ImageSource.camera),
              child: const Text('Pick Video from Camera'),
            ),
            ElevatedButton(
              onPressed: () => controller.pickVideo(ImageSource.gallery),
              child: const Text('Pick Video from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/foto');
              }, 
              child: const Text('Pilih Foto'),
            ),
          ],
        ),
      ),
    );
  }
}

