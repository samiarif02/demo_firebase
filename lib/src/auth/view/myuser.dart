import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/auth/view/update_view.dart';
import 'package:demo_firebase/utils/field_validations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/heights_widths.dart';
import '../model/user_model.dart';
import '../view_model/auth_vm.dart';

class MyUser extends StatefulWidget {
  const MyUser({super.key});

  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {

  FocusNode passwordFN = FocusNode();
  FocusNode confirmPassFN = FocusNode();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  bool isObscure1 = true;
  bool isObscure2 = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, authVm, child) => Container(
      color: R.colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h4,
              const Text('User Screen'),
              h3,
              FutureBuilder<UserModel>(
                  future: authVm.readFutureUser(authVm.userModel.id!),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      final data = snapshot.data!;
                      // print(snapshot.data);

                      return show(data);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              h2,
              AppButton(
                  buttonTitle: 'update_name',
                  textColor: R.colors.white,
                  onTap: () {

                    Get.bottomSheet(
                      const UpdateSheet(),
                      isScrollControlled: true,
                    );
                    setState(() {});
                  }),
              h2,
              Form(
                key: _formKey,
                  child: Column(
                    children: [
                      passwordField(),
                      h1,
                      confirmPasswordField(),
                      h2,
                      AppButton(
                          buttonTitle: 'change_password',
                          textColor: R.colors.white,
                          onTap: () async {
                            // await context.read<AuthVm>().deleteUser();
                            if (_formKey.currentState!.validate()) {
                              authVm.changePassword(passwordController.text, confirmPassController.text);
                            }
                            // Get.offAndToNamed(LoginView.route);
                          }),
                    ],
                  )
              ),
              h2,
              AppButton(
                  buttonTitle: 'delete',
                  textColor: R.colors.white,
                  onTap: () async {
                    await context.read<AuthVm>().deleteUser();
                    Get.offAndToNamed(LoginView.route);
                  })
            ],
          ),
        ),
      ),
    ));
  }

  Widget show(UserModel user) {
    return SizedBox(
      child: Column(
        children: [
          Image.network(
            user.profileImg.toString(),
            height: 25.h,
          ),
          h3,
          Text(
            'Login Email : ${user.email}',
            textAlign: TextAlign.left,
            style: R.textStyles
                .poppinsRegular(color: R.colors.black, fontSize: 13.sp),
          ),
          h2,
          Text(
            "Full Name : ${user.fullName}",
            textAlign: TextAlign.left,
            style: R.textStyles
                .poppinsRegular(color: R.colors.black, fontSize: 13.sp),
          ),
        ],
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

}
