// ignore_for_file: library_private_types_in_public_api

import 'package:sizer/sizer.dart';
import 'package:demo_firebase/resources/localization/app_localization.dart';

import '../resources/resources.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldTitle;
  final String hintText;
  final String? initialVal;
  final String? Function(String?)? validator;
  final String Function(String)? onChanged;
  final GestureTapCallback? onTap;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? maxLength;
  final bool obscureText;
  final bool readOnly;

  final String? Function(String?)? onSaved;

  const AppTextFormField(
      {Key? key,
        this.onSaved,
        this.maxLines,
        this.maxLength,
        this.controller,
        required this.hintText,
        this.initialVal,
        this.validator,
        this.suffixIcon,
        this.inputAction,
        this.inputType,
        this.onTap,
        this.obscureText = true,
        this.focusNode,
        this.onChanged,
        this.fieldTitle = "",
        this.readOnly = false})
      : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldTitle != "")
            Container(
              margin: const EdgeInsets.only(left: 4, top: 15, bottom: 5),
              child: Text(
               widget.fieldTitle?.L() ?? "",
                style: R.textStyles.poppinsRegular().copyWith(
                  fontSize: 13.sp,
                  color: R.colors.greyColor,
                ),
              ),
            ),
          TextFormField(
            onSaved: widget.onSaved,
            maxLength: widget.maxLength,
            initialValue: widget.initialVal,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines??1,
            obscureText: widget.obscureText,
            onChanged: widget.onChanged,
            validator: widget.validator,
            onTap: widget.onTap,
            controller: widget.controller,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
            focusNode: widget.focusNode,

            // cursorColor: AppColors.greenColor,
    style: R.textStyles.poppinsRegular(
    color: R.colors.fieldTextColor,
    fontSize: 12.sp,),
            decoration: InputDecoration(
              isDense: true,
              fillColor: R.colors.fieldTextColor,
              filled: true,
              focusColor: R.colors.red,
              hintText:
                widget.hintText.L(),
              hintStyle: R.textStyles.poppinsRegular().copyWith(
                fontSize: 12.sp,
                color: R.colors.greyColor,
              ),
              suffixIcon: widget.suffixIcon,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: R.colors.greyColor),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: R.colors.transparent),
                  borderRadius: BorderRadius.circular(8)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: R.colors.red),
                  borderRadius: BorderRadius.circular(8)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: R.colors.red),
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
