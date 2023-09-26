// import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
// import 'package:demo_firebase/utils/display_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../../resources/resources.dart';
// import '../../../utils/heights_widths.dart';
// import '../../auth/model/user_model.dart';
// import '../model/base_model.dart';
// import '../view_model/base_vm.dart';
//
// class ChatDetail extends StatefulWidget {
//   static String route = '/ChatDetail';
//
//   const ChatDetail({Key? key,}) : super(key: key);
//
//   @override
//   State<ChatDetail> createState() => _ChatDetailState();
// }
//
// class _ChatDetailState extends State<ChatDetail> {
//   TextEditingController chatController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     chatController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer2<AuthVm,ChatVM>(
//         builder: (context, authVm,chatVM, child) => Scaffold(
//             backgroundColor: R.colors.black,
//             body: Padding(
//               padding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
//               child: Column(
//                 children: [
//                   h3,
//                   StreamBuilder(
//                       stream: authVm.readStreamUser(authVm.userModel.id.toString()),
//                       builder: (context, snapshot) {
//                         if (snapshot.data != null) {
//                           final data = snapshot.data!;
//                           // print(snapshot.data);
//
//                           return detailBar(datal);
//                         }
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }),
//
//                   Expanded(
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
//                       itemCount: chatVM.messagesList.length,
//                       itemBuilder: (context, index) => Align(
//                         alignment: chatVM.messagesList[index].isSender
//                             ? Alignment.topRight
//                             : Alignment.topLeft,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(vertical: 1.h),
//                           decoration: BoxDecoration(
//                             color: chatVM.messagesList[index].isSender
//                                 ? R.colors.secondary.withOpacity(1)
//                                 : R.colors.greyColor,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               vertical: 3.w, horizontal: 1.h),
//                           child: Text(
//                             chatVM.messagesList[index].messageContent,
//                             style: R.textStyles.poppinsRegular(
//                                 fontWeight: FontWeight.w400,
//                                 color: R.colors.white,
//                                 fontSize: 10.sp),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 9.h,
//                   )
//                 ],
//               ),
//             ),
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerFloat,
//             bottomSheet: Container(
//                 color: R.colors.black,
//                 padding: EdgeInsets.symmetric(horizontal: 3.w),
//                 child: chatField(chatVM)
//             ))
//     );
//   }
//
//   Widget chatField(ChatVM chatVM) {
//     return TextFormField(
//       controller: chatController,
//       keyboardType: TextInputType.text,
//       textInputAction: TextInputAction.done,
//       onTap: () {
//         setState(() {});
//       },
//       style: R.textStyles.poppinsRegular(
//         color: R.colors.fieldTextColor,
//         fontSize: 12.sp,
//       ),
//       decoration: R.decoration.fieldDecoration(
//         fillColor: R.colors.greyColor.withOpacity(0.35),
//         suffixIcon: InkWell(
//             onTap: () {
//               if (chatController.text.isNotEmpty) {
//                 _scrollController.animateTo(
//                     _scrollController.position.maxScrollExtent +
//                         100,
//                     duration: const Duration(
//                       milliseconds: 300,
//                     ),
//                     curve: Curves.easeOut);
//                 String message = chatController.text;
//                 chatController.clear();
//                 chatVM.update();
//                 chatVM.sendMessage(
//                   message,
//                 );
//                 chatVM.update();
//               }
//             },
//             child: Image.asset(R.images.send)),
//         hintText: "enter_your_message",
//         hintTextStyle: R.textStyles
//             .poppinsRegular(fontSize: 10.sp, color: R.colors.fieldTextColor),
//       ),
//     );
//   }
//
//   Widget detailBar (UserModel user){
//     return Container(
//       height: 12.h,
//       width: 93.w,
//       padding: EdgeInsets.symmetric(horizontal: 3.w),
//       margin: EdgeInsets.symmetric(vertical: 1.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: R.colors.white.withOpacity(0.2),
//       ),
//       child: Row(
//         children: [
//           DisplayImage(
//             isCircle: true,
//             isAllowOnTap: true,
//             width: 12.w,
//             height: 12.w,
//             borderRadius: 0,
//             imageUrl: user.profileImg.toString(),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${user.fullName}',
//                   style: R.textStyles.poppinsRegular(
//                       fontWeight: FontWeight.w700,
//                       color: R.colors.white,
//                       fontSize: 13.sp),
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor:
//                       //widget.chatModel.status == 'Online'
//                       //  ? R.colors.green :
//                       R.colors.red,
//                       radius: 3,
//                     ),
//                     Text(
//                       " Online",
//                       style: R.textStyles.poppinsRegular(
//                           fontWeight: FontWeight.w400,
//                           color: R.colors.lightGrey,
//                           fontSize: 11.sp),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
