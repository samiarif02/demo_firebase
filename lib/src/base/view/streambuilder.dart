import 'package:demo_firebase/src/auth/view/update_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/heights_widths.dart';
import '../../../utils/widgets/global_widgets.dart';
import '../../auth/model/user_model.dart';
import '../../auth/view_model/auth_vm.dart';

class StreamView extends StatefulWidget {
  const StreamView({super.key});

  @override
  State<StreamView> createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, authVm, child) => Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        color: R.colors.white,
      ),      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h2,
            GlobalWidgets.bottomSheetBar(width: 10.w),
            const Text('Stream builder'),
            h3,
            Expanded(
                child: StreamBuilder<List<UserModel>>(
                    stream: authVm.readStreamAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final data = snapshot.data!;
                        // print(snapshot.data);

                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) => show(data[index]),);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),


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
