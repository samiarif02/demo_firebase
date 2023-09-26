
import 'package:demo_firebase/src/auth/view/otp_view.dart';
import 'demo.dart';
import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/view/forgetpass_view.dart';
import 'package:demo_firebase/src/auth/view/signup_view.dart';
import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/field_validations.dart';
import '../../../utils/heights_widths.dart';

class LoginView extends StatefulWidget {
  static String route = "/login";

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  TextEditingController emailController =
      TextEditingController(text: "samiarif02@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: '12345As.');
  bool isObscure1 = true;
  final formKey = GlobalKey<FormState>();
   // User? currentUser = FirebaseAuth.instance.currentUser;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFN.dispose();
    passwordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(
        builder: (context, authVm, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: R.colors.secondary,
                title: Text(
                  'Login Page',
                  style: R.textStyles.poppinsRegular(color: R.colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        titleWidget("email"),
                        h1,
                        emailField(),
                        h1P5,
                        titleWidget("password"),
                        h1,
                        passwordField(),
                        h1P5,
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(ForgetPass.route);
                            },
                            child: Text(
                              "forgot_password".L(),
                              style: R.textStyles.poppinsRegular(
                                  fontSize: 10.sp,
                                  color: R.colors.lightTextColor,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        h4P5,
                        AppButton(
                          buttonTitle: "login",
                          onTap: () async {
                            //FirebaseFirestore.instance.collection("product").doc("Ixfeqm4BfenZvK1T3zlC").get().then((value)=>debugPrint(jsonEncode(value.data())));

                            // if (formKey.currentState!.validate()) {
                            await authVm.loginIn(emailController.text , passwordController.text);
                            // }
                          },
                          buttonWidth: Get.width,
                          textSize: 14.sp,
                          textPadding: 8.sp,
                        ),
                        h4P5,
                        AppButton(
                          buttonTitle: "otp_verification",
                          onTap: ()  {
                            Get.toNamed(OTPVerificationView.route);
                          },
                          buttonWidth: Get.width,
                          textSize: 14.sp,
                          textPadding: 8.sp,
                        ),
                        h3,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "don't_have_an_acc".L(),
                            style: R.textStyles.poppinsRegular(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: R.colors.lightTextColor,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'create_account'.L(),
                                style: R.textStyles.poppinsMedium(
                                    fontSize: 10.sp,
                                    color: R.colors.secondary,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(SignupView.route);
                                  },
                              ),
                            ],
                          ),
                        ),
                        h4P5,
                        AppButton(
                          buttonTitle: "next",
                          onTap: ()  {
                            Get.toNamed(Demo.route);
                          },
                          buttonWidth: Get.width,
                          textSize: 14.sp,
                          textPadding: 8.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
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
      textInputAction: TextInputAction.done,
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
}
