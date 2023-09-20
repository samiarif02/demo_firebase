import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../resources/resources.dart';
import 'app_button.dart';
import 'heights_widths.dart';

class DialogBox extends StatefulWidget {
  final bool showClose;
  final String image;
  final String title;
  final String description;
  final String buttonTitle;
  final bool isShowButton;
  final Function onTap;
  final double width;
  const DialogBox({super.key, this.showClose = true, required this.image, required this.title, this.description = "", this.buttonTitle = "", required this.isShowButton, required this.onTap, required this.width});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {Get.back();},
      child: Scaffold(
        backgroundColor: R.colors.transparent,
        body: Center(
          child: Container(
            width: widget.width,
            // margin: EdgeInsets.only(bottom: 40.h),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: R.colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                h1P5,
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Icon(Icons.close, color: R.colors.greyColor),
                    )
                ),
                Image.asset(widget.image, scale: 3.5),
                h2,
                Text(widget.title.L(),
                  style: R.textStyles.sfProText(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400
                  ),),
                h2,
                Text(
                  widget.description.L(),
                  textAlign: TextAlign.center,
                  style: R.textStyles.poppinsRegular(
                    fontSize: 12.sp,
                    color: R.colors.greyColor,
                  ),
                ),
                Visibility(
                  visible: widget.isShowButton,
                  child: Column(
                    children: [
                      h3,
                      AppButton(buttonTitle: widget.buttonTitle, onTap: () {}, textPadding: 9.sp)
                    ],
                  ),
                ),
                h3
              ],
            ),
          ),
        ),
      ),
    );
  }
}
