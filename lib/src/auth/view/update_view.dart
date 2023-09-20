import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/field_validations.dart';
import '../../../utils/heights_widths.dart';

class UpdateSheet extends StatefulWidget {
  const UpdateSheet({super.key});

  @override
  State<UpdateSheet> createState() => _UpdateSheetState();
}

class _UpdateSheetState extends State<UpdateSheet> {

  FocusNode nameFN = FocusNode();
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  //final docUser = FirebaseFirestore.instance.collection('user').doc(user?.uid);

  // AuthCredential ?u = AuthCredential(providerId: EmailAuthProvider.PROVIDER_ID, signInMethod: EmailAuthProvider.EMAIL_LINK_SIGN_IN_METHOD);

  //
  // Future updateData () async {
  //   await user?.reauthenticateWithCredential(u!);
  //   await user?.updateEmail(emailController.text);
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = context.read<AuthVm>().userModel.fullName ?? "";
      setState(() {
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFN.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 4.h),
      decoration: BoxDecoration(
        color: R.colors.white,
          borderRadius: const BorderRadius.vertical( top: Radius.circular(25)),
      ),
      child:  Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleWidget("full_name"),
            h1,
            nameField(),

            h3,
            AppButton(
              buttonTitle: "update_name",
              textColor: R.colors.white,
              onTap: ()  async {
                context.read<AuthVm>().userModel.fullName = nameController.text;
                await context.read<AuthVm>().updateUser(context.read<AuthVm>().userModel);
                Get.back();
                  }
            ),
          ],
        ),
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

  Widget nameField() {
    return TextFormField(
      focusNode: nameFN,
      controller: nameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      onTap: () {
        setState(() {});
      },

      validator: FieldValidator.validateName,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: R.textStyles.poppinsRegular(
        color: R.colors.fieldTextColor,
        fontSize: 12.sp,
      ),
      decoration: R.decoration.fieldDecoration(
        hintText: "enter_new_name",
        hintTextStyle: R.textStyles
            .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
        focusNode: nameFN,
      ),
    );
  }


}
