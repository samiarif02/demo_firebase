import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'localization/app_localization.dart';
import 'resources.dart';

class AppDecoration {
  InputDecoration fieldDecoration({
    Widget? preIcon,
    String? labelText,
    required String hintText,
    Widget? suffixIcon,
    double? radius,
    double? horizontalPadding,
    double? verticalPadding,
    double? iconMinWidth,
    double? suffixMaxHeight,
    double? suffixMinHeight,
    Color? fillColor,
    FocusNode? focusNode,
    bool? isLabelTranslated = true,
    TextStyle? hintTextStyle,
    TextStyle? textStyle,
    bool showCounter = false
  }) {
    return InputDecoration(
      suffixIconConstraints: BoxConstraints(
          minWidth: iconMinWidth ?? 60,
          minHeight:suffixMinHeight?? 50,maxHeight:suffixMaxHeight?? 50
      ),
      contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 16, vertical: verticalPadding ?? 14),
      fillColor: fillColor ?? R.colors.textFieldFillColor,
      hintText: LocalizationMap.getValue(hintText),
      prefixIcon: preIcon,
      suffixIcon: suffixIcon != null ? Container(child: suffixIcon) : null,
      hintStyle:hintTextStyle?? R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 10.sp,
        fontWeight: FontWeight.w300,
      ),
      counterText: showCounter ? null : "",
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8),),
        borderSide: BorderSide(color: R.colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8),),
        borderSide: BorderSide(color: R.colors.transparent),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        borderSide:  BorderSide(color: R.colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        borderSide: BorderSide(color: R.colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
        borderSide: BorderSide(color: R.colors.red),
      ),
      filled: true,
    );
  }


  static appContainerDecoration({required Widget child,double horPadding=5,double verticalPadding=1.5 ,double? verticalMargin})
  {
    return Container(
      decoration: BoxDecoration(
          color: R.colors.greyBoxColor,
          borderRadius: BorderRadius.circular(12)
      ),
        padding: EdgeInsets.symmetric(horizontal: horPadding.w,vertical: verticalPadding.h),
        margin: EdgeInsets.symmetric(horizontal: 4.w,vertical:verticalMargin?? 2.h),
      child: child,
    );
  }
}
