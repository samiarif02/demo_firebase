import 'dart:developer';
import 'package:demo_firebase/utils/permission_popup.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class GlobalFunctions {
  static String getOrdinal(DateTime date) {
    String day;
    if (date.day >= 11 && date.day <= 13) {
      day = '${date.day}th}';
    }
    switch (date.day % 10) {
      case 1:
        day = '${date.day}st';
      case 2:
        day = '${date.day}nd';
      case 3:
        day = '${date.day}rd';
      default:
        day = '${date.day}th';
    }
    return '$day${DateFormat(" MMMM yyyy").format(DateTime.now())}';
  }

  static Future<bool> checkPermissionStatus(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.denied:
        if (!await Permission.camera.request().isGranted) {
          Get.dialog(const PermissionDialog());
        } else {
          return true;
        }
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        Get.dialog(const PermissionDialog());

        return false;
      case PermissionStatus.limited:
        Get.dialog(const PermissionDialog());

        return false;
      case PermissionStatus.permanentlyDenied:
        Get.dialog(const PermissionDialog());
        return false;
      default:
        // Handle other permission statuses
        log('Camera permission unknown');
        return false;
    }
  }
}
