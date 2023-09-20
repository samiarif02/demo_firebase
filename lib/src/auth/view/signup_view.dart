import 'dart:developer';

import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/model/user_model.dart';
import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/utils/bot_toast/zbot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../resources/resources.dart';
import '../../../services/image_picker/image_picker_option.dart';
import '../../../utils/app_button.dart';
import '../../../utils/field_validations.dart';
import '../../../utils/heights_widths.dart';
import 'dart:io';

import '../view_model/auth_vm.dart';

class SignupView extends StatefulWidget {
  static String route = "/signup";

  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  FocusNode fullnameFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isObscure1 = true;
  bool isObscure2 = true;
  bool isChecked1 = true;
  String imageUrl = '';
  final _formKey = GlobalKey<FormState>();
  static File? imageFile;
  final _firebaseStorage = FirebaseStorage.instance;
  // final docUser = FirebaseFirestore.instance.collection('user').doc();
  // DocumentReference ref = FirebaseFirestore.instance.collection('user').doc();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullnameController.dispose();
    confirmPassController.dispose();
    fullnameFN.dispose();
    confirmPassFN.dispose();
    emailFN.dispose();
    passwordFN.dispose();
    super.dispose();
  }



  // Future signUp() async {
  //    if (passwordController.text ==
  //        confirmPassController.text) {
  //      await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //          email: emailController.text, password: passwordController.text);
  //
  //      addUserDetails(
  //        fullnameController.text,
  //        emailController.text,
  //        imageUrl
  //      );
  //      showDialog(
  //        builder: (context) {
  //          return AlertDialog(
  //            content: Text(
  //              "Your Account is Created!. Login Now. ",
  //              style: R.textStyles.poppinsRegular(color: R.colors.black),
  //            ),
  //          );
  //        }, context: context,
  //      );
  //    } else {
  //      showDialog(
  //        context: context,
  //        builder: (context) {
  //          return AlertDialog(
  //            content: Text(
  //              "Password doesn't match.",
  //              style: R.textStyles.poppinsRegular(color: R.colors.black),
  //            ),
  //          );
  //        },
  //      );
  //    }
  //  }

  // //Future addUserDetails(String fullName,String email,String imgUrl) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'fullname ': fullName,
  //     'email': email,
  //     'Image Url': imgUrl
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: R.colors.secondary,
        title: Text(
          'SignUp Page',
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
                h3,
                titleWidget("full_name"),
                h1,
                fullNameField(),
                h1P5,
                titleWidget("email"),
                h1,
                emailField(),
                h1P5,
                titleWidget("password"),
                h1,
                passwordField(),
                h1P5,
                titleWidget("confirm_password"),
                h1,
                confirmPasswordField(),
                h2,
                AppButton(
                  buttonTitle: 'upload_image',
                  buttonWidth: 38.w,
                  color: imageFile == null ? R.colors.red : R.colors.green,
                  onTap: () {
                    Get.dialog(ImagePickerOption(
                      uploadImage: (value) async {
                        if (value != null) {
                          imageFile = value;

                          setState(() {});
                        }
                      },
                    ));
                  },
                ),
                h5,
                AppButton(
                  buttonTitle: 'create_account',
                  color: R.colors.secondary,
                  borderRadius: 30,
                  textSize: 14.sp,
                  textColor: R.colors.white,
                  shadowColor: R.colors.transparent,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final ref = await _firebaseStorage
                          .ref()
                          .child('images/imageName')
                          .putFile(imageFile!)
                          .whenComplete(() {});
                      imageUrl = await _firebaseStorage
                          .ref()
                          .child('images/imageName')
                          .getDownloadURL();
                      if (imageUrl != null) {
                        UserModel newUser = UserModel(
                          email: emailController.text,
                          fullName: fullnameController.text,
                          profileImg: imageUrl,
                          id: "",
                        );
                        log(" model beofre  ${newUser.id}");
                        await context.read<AuthVm>().createUser(newUser,confirmPassController.text);
                      }
                    }
                  },
                ),
                h2,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "already_have_an_acc".L(),
                    style: R.textStyles.poppinsRegular(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: R.colors.lightTextColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'login'.L(),
                        style: R.textStyles.sfProText(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: R.colors.secondary,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(LoginView.route);
                          },
                      ),
                    ],
                  ),
                ),
                h4
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fullNameField() {
    return TextFormField(
      focusNode: fullnameFN,
      controller: fullnameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onTap: () {
        setState(() {});
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(emailFN);
        setState(() {});
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(emailFN);
        setState(() {});
      },
      validator: FieldValidator.validateName,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: "full_name",
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        focusNode: fullnameFN,
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
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(passwordFN);
        setState(() {});
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(passwordFN);
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

  Widget passwordField() {
    return TextFormField(
      focusNode: passwordFN,
      controller: passwordController,
      obscureText: isObscure1,
      textInputAction: TextInputAction.next,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      validator: FieldValidator.validatePassword,
      onSaved: (newValue) {
        setState(() {});
      },
      onTap: () => setState(() {}),
      onChanged: (value) {
        setState(() {});
      },
      onFieldSubmitted: (value) {
        setState(() {});
      },
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: 'enter_your_password',
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isObscure1 = !isObscure1;
            });
          },
          child: Icon(
            isObscure1
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: passwordFN.hasFocus
                ? R.colors.secondary
                : R.colors.fieldTextColor,
          ),
        ),
        focusNode: passwordFN,
      ),
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      focusNode: confirmPassFN,
      controller: confirmPassController,
      obscureText: isObscure2,
      textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) =>
          FieldValidator.validatePasswordMatch(value, passwordController.text),
      onSaved: (newValue) {
        setState(() {});
      },
      onTap: () => setState(() {}),
      onChanged: (value) {
        setState(() {});
      },
      onFieldSubmitted: (value) {
        setState(() {});
      },
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: 'confirm_password',
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              isObscure2 = !isObscure2;
            });
          },
          child: Icon(
            isObscure2
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: confirmPassFN.hasFocus
                ? R.colors.secondary
                : R.colors.fieldTextColor,
          ),
        ),
        focusNode: confirmPassFN,
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
