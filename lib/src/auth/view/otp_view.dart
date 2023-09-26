import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/bot_toast/zbot_toast.dart';
import '../../../utils/field_validations.dart';
import '../../../utils/heights_widths.dart';
import '../../../utils/keyboard_config.dart';

class OTPVerificationView extends StatefulWidget {
  static String route = "/OTPVerificationView";

  const OTPVerificationView({super.key});

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {

  final formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  FocusNode otpFN = FocusNode();
  bool disableButton = true;

  dynamic data;
  bool? isSignUp;
  FocusNode numFN = FocusNode();
  TextEditingController numController = TextEditingController( text: '+923414100798');


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      data = ModalRoute.of(context)?.settings.arguments;
      if (data != null) {
        if (data['isSignUp'] != null) {
          isSignUp = data['isSignUp'];
        }
      }
      setState(() {});
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, authVm, child) => Scaffold(
      backgroundColor: R.colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 9.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                h15,
                h7,
                Text(
                  "otp_verification".L(),
                  style: R.textStyles
                      .poppinsMedium(color: R.colors.textColor, fontSize: 16.sp),
                ),
                h1P5,
                Text(
                 authVm.otpFieldVisibility ?  "enter_otp_statement".L() :  "enter_num_statement".L(),
                  style: R.textStyles.poppinsRegular(
                    fontSize: 10.sp,
                    color: R.colors.greyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                h6,
                numField(),
                h8,
                Visibility(
                    visible: authVm.otpFieldVisibility,
                    child: pinCodeField()),
                h1,
                // TextButton(
                //   onPressed: (){
                //
                //   },
                //   child: Text(
                //     "request_again".L(),
                //     style: R.textStyles.poppinsRegular(
                //         color: R.colors.secondary,
                //         fontSize: 12.sp,
                //         decoration: TextDecoration.underline),
                //   ),
                // ),
                // h2,
                AppButton(
                  buttonTitle: authVm.otpFieldVisibility ? "verify_otp" : 'verify_your_number',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if(authVm.otpFieldVisibility){
                      await authVm.verifyOTPCode(otpController.text);
                    }
                    else{
                      await authVm.verifyPhoneNumber(numController.text);
                    }
                    }
                  },
                  buttonWidth: Get.width,
                  textSize: 13.sp,
                  textPadding: 10.sp,
                  color: otpController.text.length < 6
                      ? R.colors.greyColor
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget pinCodeField() {
    return KeyboardActions(
        config: buildConfigDone(context, otpFN, nextFocus: FocusNode(), isDone: true),
        disableScroll: true,
        autoScroll: false,
        child: PinCodeTextField(
          focusNode: otpFN,
          textStyle: R.textStyles.poppinsMedium(
            color: R.colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          showCursor: true,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 45,
            fieldWidth: 45,
            activeColor: R.colors.transparent,
            activeFillColor: R.colors.textFieldFillColor,
            selectedColor: R.colors.transparent,
            selectedFillColor: R.colors.textFieldFillColor,
            disabledColor: R.colors.transparent,
            inactiveColor: R.colors.transparent,
            inactiveFillColor: R.colors.textFieldFillColor,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: R.colors.transparent,
          cursorColor: R.colors.fieldTextColor,
          enableActiveFill: true,
          // errorAnimationController: errorController,
          controller: otpController,
          keyboardType: TextInputType.number,
          validator: FieldValidator.validateOTP,
          onCompleted: (v) {
            disableButton = false;
            setState(() {});
          },
          onChanged: (value) {
            setState(() {});
          },
          beforeTextPaste: (text) {
            return true;
          },
        )
    );
  }

  Widget numField() {
    return TextFormField(
      focusNode: numFN,
      controller: numController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onTap: () {
        setState(() {});
      },

      validator: FieldValidator.validateEmptyField,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: "enter_your_num",
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        focusNode: numFN,
      ),
    );
  }
}
