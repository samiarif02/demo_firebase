import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/auth/view/update_view.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, authVm, child) => Container(
      color: R.colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h4,
            const Text('User Screen'),
            h3,
            Expanded(
                child: FutureBuilder<UserModel>(
                    future: authVm.readFutureUser(authVm.userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final data = snapshot.data!;
                        // print(snapshot.data);

                        return SingleChildScrollView(child: show(data));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),

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

}
