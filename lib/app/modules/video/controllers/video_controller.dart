import 'package:get/get.dart';
 import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
class VideoController extends GetxController {
  //TODO: Implement VideoController
  final ImagePicker _picker = ImagePicker();
  final box = GetStorage();
  
  var selectedVideoPath = ''.obs;
  var isVideoPlaying = false.obs;
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    _loadStoredData();
  }

  @override
  void onClose() {
    videoPlayerController?.dispose();
    super.onClose();
  }

  Future<void> pickVideo(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile != null) {
        selectedVideoPath.value = pickedFile.path;
        box.write('videoPath', pickedFile.path);

        videoPlayerController =
            VideoPlayerController.file(File(pickedFile.path))
              ..initialize().then((_) {
                videoPlayerController!.play();
                isVideoPlaying.value = true;
                update();
              });
      } else {
        print('No video selected.');
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  void _loadStoredData() {
    selectedVideoPath.value = box.read('videoPath') ?? '';

    if (selectedVideoPath.value.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.file(File(selectedVideoPath.value))
            ..initialize().then((_) {
              videoPlayerController!.play();
            });
    }
  }

  void togglePlayPause() {
    if (videoPlayerController != null) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isVideoPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isVideoPlaying.value = true;
      }
      update();
    }
  }
}


