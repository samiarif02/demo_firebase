import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../utils/global_functions.dart';

class ImagePickerServices {
  // get profile image function
  static File? profileImage;
  static File? coverImage;
  static List<File>? photoIDList;

  static Future<bool> checkFileSize(path, {bool isVideo = false}) async {
    var fileSizeLimit = isVideo ? 1024 * 10 : 1024 * 100;
    File f = File(path);
    var s = f.lengthSync();
    log(s.toString()); // returns in bytes
    var fileSizeInKB = s / 1024;
    // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
    // var fileSizeInMB = fileSizeInKB / 1024;
    debugPrint("_____________FILES SIZE IN KB:$fileSizeInKB"); // returns in bytes

    if (fileSizeInKB > fileSizeLimit) {
      debugPrint("File size greater than the limit");
      return false;
    } else {
      debugPrint("file can be selected");
      return true;
    }
  }
  // get profile image function

  static Future getProfileImage({
    bool isCamera = false,
    bool? isSizeOptional = false,
    bool isCoverImage = false,
    BuildContext? context,
  }) async {
    try {
      final pickedFile = isCamera
          ? await ImagePicker().pickImage(
              source: ImageSource.camera,
              imageQuality: 85,
            )
          : await ImagePicker().pickImage(
              source: ImageSource.gallery,
              imageQuality: 85,
            );
      if (pickedFile != null) {
        File? croppedFile = await cropImage(isCoverImage: isCoverImage,filePath: pickedFile.path, isOptionsEnabled: isSizeOptional!);
        profileImage = File(croppedFile?.path ?? "");
      }
    } catch (e) {
      if (e.toString().contains("camera_access_denied")) {
        var status = await Permission.camera.status;
        await GlobalFunctions.checkPermissionStatus(status);
      }
    }
  }

  static Future<File?> getVideo({
    bool isCamera = false,
    bool? isSizeOptional = false,
    BuildContext? context,
  }) async {
    try {
      final pickedFile = isCamera
          ? await ImagePicker().pickVideo(
        source: ImageSource.camera,
      )
          : await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
      return File(pickedFile?.path ?? "");
    } catch (e) {
      if (e.toString().contains("camera_access_denied")) {
        var status = await Permission.camera.status;
        await GlobalFunctions.checkPermissionStatus(status);
      }
    }
    return null;
  }

  static List<File>? tempList = [];

  static Future<File?> cropImage({required String filePath,required bool isCoverImage, required bool isOptionsEnabled}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets:
      isCoverImage
          ? [
        CropAspectRatioPreset.ratio16x9
      ]
          :
      isOptionsEnabled
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.square,
            ],

      // uiSettings: buildUiSettings(Get.context!),
    );
    File tempFile = File(croppedFile!.path);

    return tempFile;
  }
}
