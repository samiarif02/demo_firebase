import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../resources/localization/app_localization.dart';
import '../resources/resources.dart';

AppBar titleAppBar({required String title, Color? color, bool? titleCenter}) {
  return AppBar(
    elevation: 0,
    backgroundColor: color ?? (R.colors.white),
    // foregroundColor: color ?? R.colors.primary,
    // shadowColor: color ?? R.colors.white,
    centerTitle: titleCenter ?? true,
    title: Text(
      LocalizationMap.getValue(title),
      style: R.textStyles.poppinsMedium(
          fontSize: 12.5.sp,
          color: R.colors.white,
          fontWeight: FontWeight.w400,
          letterSpacing: 0),
    ),
    leading: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          Get.back();
        },
        child:  Icon(
          Icons.arrow_back,
          color:
          R.colors.white,
          size: 23,
        )),
  );
}


