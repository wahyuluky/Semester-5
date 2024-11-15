import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/foto_controller.dart';
import 'dart:io';

class FotoView extends GetView<FotoController> {
  const FotoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
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
                return controller.isImageLoading.value
                    ? const CircularProgressIndicator()
                    : controller.selectedImagePath.value == ''
                        ? const Text('No image selected')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(controller.selectedImagePath.value),
                              fit: BoxFit.cover,
                            ),
                          );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.pickImage(ImageSource.camera),
              child: const Text('Pick Image from Camera'),
            ),
            ElevatedButton(
              onPressed: () => controller.pickImage(ImageSource.gallery),
              child: const Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/video');
              }, 
              child: const Text('Pilih Video'),
            ),
          ],
        ),
      ),
    );
  }
}


