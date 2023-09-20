import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/localization/app_localization.dart';
import '../../resources/resources.dart';
import 'image_picker_services.dart';

class ImagePickerOption extends StatefulWidget {
  final ValueChanged<File?>? uploadImage;
  final ValueChanged<bool>? removeImage;
  final bool? isOptionEnable;
  final bool isCoverImage;
  final bool? isVideo;
  const ImagePickerOption({
    this.uploadImage,
    Key? key,
    this.isOptionEnable = false,
    this.isCoverImage = false,
    this.isVideo = false,
    this.removeImage,
  }) : super(key: key);

  @override
  ImagePickerOptionState createState() => ImagePickerOptionState();
}

class ImagePickerOptionState extends State<ImagePickerOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.only(bottom: Get.height * .05, left: Get.width * .08, right: Get.width * .08),
            padding: EdgeInsets.only(
                bottom: Get.height * .05, top: Get.height * .02, left: Get.width * .08, right: Get.width * .08),
            width: Get.width,
            decoration: BoxDecoration(color: R.colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Choose option", style: R.textStyles.poppinsRegular(fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Get.height * .02,
                ),
                InkWell(
                  onTap: () {
                    if (widget.isVideo!) {
                      ImagePickerServices.getVideo(
                              isSizeOptional: widget.isOptionEnable, isCamera: false, context: context)
                          .then((value) async {
                        if (value != null) {
                          widget.uploadImage!(value);
                        }
                      });
                    } else {
                      ImagePickerServices.getProfileImage(
                          isCoverImage:widget.isCoverImage,
                              isSizeOptional: widget.isOptionEnable, isCamera: false, context: context)
                          .then((value) async {
                        if (ImagePickerServices.profileImage != null) {
                          widget.uploadImage!(ImagePickerServices.profileImage);
                          ImagePickerServices.profileImage = null;
                        }
                      });
                    }

                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image, size: 20, color: R.colors.greyColor),
                      SizedBox(
                        width: Get.width * .03,
                      ),
                      Text(LocalizationMap.getValue("gallery"),
                          style: R.textStyles.poppinsRegular(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () async {
                    if (widget.isVideo!) {
                      ImagePickerServices.getVideo(
                              isSizeOptional: widget.isOptionEnable, isCamera: true, context: context)
                          .then((value) async {
                        if (value != null) {
                          widget.uploadImage!(value);
                        }
                      });
                    } else {
                      ImagePickerServices.getProfileImage(
                          isCoverImage:widget.isCoverImage,
                              isSizeOptional: widget.isOptionEnable, isCamera: true, context: context)
                          .then((value) async {
                        if (ImagePickerServices.profileImage != null) {
                          widget.uploadImage!(ImagePickerServices.profileImage);
                          ImagePickerServices.profileImage = null;
                        }
                      });
                    }

                    Navigator.pop(Get.context!);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera, size: 20, color: R.colors.greyColor),
                      SizedBox(
                        width: Get.width * .03,
                      ),
                      Text(LocalizationMap.getValue("camera"),
                          style: R.textStyles.poppinsRegular(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
