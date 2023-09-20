import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../resources/resources.dart';

class Helper {
  /*
  * description: Show a message
  * input: a message string
  * output: a scaffold snackBar
  */
  static Future showSnackBar(String message, {bool isError = false}) async {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: R.colors.white,
        elevation: .5,
        padding: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text(
          message,
          style: R.textStyles.poppinsMedium(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: R.colors.black,
          ),
        ),
      ),
    );
  }

  static Future errorSnackBar(String message, {bool isError = false}) async {
    return ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        backgroundColor: R.colors.red,
        elevation: .5,
        padding: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text(
          message,
          style: R.textStyles.poppinsMedium(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: R.colors.black,
          ),
        ),
      ),
    );
  }

  /*
  * description: Change colors to material colors
  * input: Color
  * Output: material color
  */
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
  static String generateRandomString(int len) {
    var r = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String key= List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
    return "$key";
  }
}
