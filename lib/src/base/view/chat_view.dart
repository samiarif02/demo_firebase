import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utils/display_image.dart';
import '../../../utils/heights_widths.dart';
import '../../auth/model/user_model.dart';
import '../view_model/base_vm.dart';
import 'chat_detailview.dart';

class ChatView extends StatelessWidget {
  static String route = '/ChatScreen';
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthVm,ChatVM>(builder: (context, authVm,chatVM, child) =>Scaffold(
        backgroundColor: R.colors.black,
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
          child: Column(
            children: [
              h4,
              Text('chats'.L(),
                style:R.textStyles.poppinsRegular(
                    fontWeight: FontWeight.w700, color: R.colors.white, fontSize: 23.sp),),

              Expanded(
                child: StreamBuilder<List<UserModel>>(
                    stream: authVm.readStreamAllUsers(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final data = snapshot.data!;
                        // print(snapshot.data);

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                //    Get.toNamed(ChatDetail.route);
                                  },
                                  child: chatsContainer(data[index])
                              ));
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        )
    ));
  }

  Widget chatsContainer(UserModel user){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.h),
      height: 11.h,
      width: 90.w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
       color: R.colors.greyColor.withOpacity(0.35)
        ),
      child: Row(
        children: [
          DisplayImage(
            isCircle: true,
            isAllowOnTap: true,
            width: 12.w,
            height: 12.w,
            borderRadius: 0,
            imageUrl: user.profileImg.toString(),
          ),
           SizedBox(width: 2.w,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Email : ${user.email}',
                //       textAlign: TextAlign.left,
                //       style: R.textStyles
                //           .poppinsRegular(color: R.colors.white, fontSize: 10.sp),
                //     ),
                //
                //     Text(chatVM.chatList[index].time,
                //       style: R.textStyles.poppinsRegular(
                //           fontWeight: FontWeight.w400, color: R.colors.lightGrey, fontSize: 10.sp),),
                //   ],
                // ),
                Text(
                  "${user.fullName}",
                  textAlign: TextAlign.left,
                  style: R.textStyles
                      .poppinsMedium(color: R.colors.white, fontSize: 13.sp),
                ),
                Text(
                  "hello! how are you?",
                  textAlign: TextAlign.left,
                  style: R.textStyles
                      .poppinsRegular(color: R.colors.lightGrey.withOpacity(0.7), fontSize: 10.sp),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
