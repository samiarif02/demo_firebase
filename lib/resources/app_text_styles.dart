import 'package:demo_firebase/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTextStyles {

  TextStyle poppinsRegular({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    TextDecoration? decoration
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w400,
      letterSpacing: letterSpacing ?? 0.48,
      decoration: decoration,
      decorationColor: color
    );
  }

  TextStyle poppinsMedium({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    TextDecoration? decoration,

  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing ?? 0.48,
      decoration: decoration
    );
  }

  TextStyle poppinsSemiBold({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w600,
      letterSpacing: letterSpacing ?? 0.48,
    );
  }

  TextStyle poppinsBold({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize ?? 12.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w700,
      letterSpacing: letterSpacing ?? 0.48,
    );
  }

  TextStyle sfProText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration
  }) {
    return TextStyle(
      fontFamily: 'sfProText',
      fontSize: fontSize ?? 11.sp,
      color: color ?? R.colors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing ?? 0,
      height: height,
        decoration: decoration,
        decorationColor: color
    );
  }

}