import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';

class GlobalWidgets {
  static Widget bottomSheetBar({double? width}) {
    return Container(
      margin: EdgeInsets.only(top: 0.h),
      width: width ?? 10.w,
      height: 1.h,
      decoration: BoxDecoration(
        color: R.colors.lightGrey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
