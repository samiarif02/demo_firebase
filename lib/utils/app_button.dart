import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../resources/resources.dart';
import '../resources/localization/app_localization.dart';
import 'heights_widths.dart';

class AppButton extends StatefulWidget {
  final String buttonTitle;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? textSize;
  final double? borderRadius;
  final double? borderWidth;
  final double? letterSpacing;
  final double? textPadding;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? buttonWidth;

  const   AppButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.textPadding,
    this.elevation,
    this.shadowColor,
    this.buttonWidth,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth ?? Get.width,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          elevation: widget.elevation ?? 0,
          padding: EdgeInsets.zero,
          side: BorderSide(color: widget.borderColor ?? R.colors.transparent, width: widget.borderWidth ?? 2),
          backgroundColor: widget.color ?? R.colors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 32),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: widget.textPadding ?? 12.sp,horizontal: widget.textPadding??2),
          child: Text(
            LocalizationMap.getValue(widget.buttonTitle),
            textAlign: TextAlign.center,
            style: R.textStyles.poppinsMedium(
                fontSize: widget.textSize ?? 12.sp,
                fontWeight: widget.fontWeight ?? FontWeight.w500,
                color: widget.textColor ?? R.colors.white,
                letterSpacing: widget.letterSpacing ?? 0.44),
          ),
        ),
      ),
    );
  }
}

class AppIconButton extends StatefulWidget {

  final String buttonTitle;
  final String icon;
  final double iconSize;
  final GestureTapCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? textSize;
  final double? borderRadius;
  final double? borderWidth;
  final double? letterSpacing;
  final double? textPadding;
  final double? elevation;
  final FontWeight? fontWeight;
  final double? buttonWidth;


  const AppIconButton({
    Key? key,
    required this.buttonTitle,
    required this.onTap,
    this.borderRadius,
    this.color,
    this.borderColor,
    this.iconSize = 4,
    this.textColor,
    this.borderWidth,
    required this.icon,
    this.textSize,
    this.letterSpacing,
    this.fontWeight,
    this.textPadding,
    this.elevation,
    this.shadowColor,
    this.buttonWidth,

  }) : super(key: key);

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: widget.buttonWidth ?? Get.width,
        child: Container(
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(widget.borderRadius ?? 28)),
          child: ElevatedButton(
            onPressed: widget.onTap,
            style: ElevatedButton.styleFrom(
              elevation: widget.elevation ?? 0,
              padding: EdgeInsets.zero,
              side: BorderSide(color: widget.borderColor ?? R.colors.transparent, width: widget.borderWidth ?? 2),
              backgroundColor: widget.color ?? R.colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 28),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: widget.textPadding ?? 12.sp),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.icon,
                    scale: widget.iconSize,
                  ),
                  w2,
                  Text(
                    LocalizationMap.getValue(widget.buttonTitle),
                    textAlign: TextAlign.center,
                    style: R.textStyles.poppinsRegular(
                        fontSize: widget.textSize ?? 12.sp,
                        fontWeight: widget.fontWeight ?? FontWeight.w400,
                        color: widget.textColor ?? R.colors.white,
                        letterSpacing: widget.letterSpacing ?? 0.44),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }



