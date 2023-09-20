import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/field_validations.dart';
import '../../../utils/heights_widths.dart';
import 'login_view.dart';

class ForgetPass extends StatefulWidget {
  static String route = "/forget";

  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  FocusNode emailFN = FocusNode();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  Future resetPassword () async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Password reset link sent! Check your email.",
            style: R.textStyles.poppinsRegular(color: R.colors.black),
          ),
        );
      },
      );
    }
    on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString(),
            style: R.textStyles.poppinsRegular(color: R.colors.black),
          ),
        );
      },
      );
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    emailFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.colors.secondary,
        title: Text(
          'Forget Password ',
          style: R.textStyles.poppinsRegular(color: R.colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                titleWidget("email"),
                h1,
                emailField(),
                h2,
                AppButton(
                  buttonTitle: 'reset_password',
                  color: R.colors.secondary,
                  borderRadius: 30,
                  textSize: 14.sp,
                  textColor: R.colors.white,
                  shadowColor: R.colors.transparent,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                       resetPassword();
                      Future.delayed(const Duration(seconds: 3),(){
                        Get.offAndToNamed(LoginView.route);
                      });
                    }
                  },
                ),
                h4
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget emailField() {
    return TextFormField(
      focusNode: emailFN,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onTap: () {
        setState(() {});
      },
      validator: FieldValidator.validateEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: "enter_your_email",
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        focusNode: emailFN,
      ),
    );
  }


  Widget titleWidget(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title.L(),
        style: R.textStyles
            .poppinsMedium(fontSize: 10.sp, color: R.colors.lightTextColor),
      ),
    );
  }
}
