import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase/src/auth/model/user_model.dart';
import 'package:demo_firebase/src/auth/view/futurebuilder.dart';
import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/auth/view/myuser.dart';
import 'package:demo_firebase/src/auth/view/streambuilder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/resources.dart';
import '../../../utils/app_button.dart';
import '../../../utils/heights_widths.dart';
import '../../auth/view/update_view.dart';
import '../../auth/view_model/auth_vm.dart';

class HomeView extends StatefulWidget {
  static String route = "/home";

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // String? documentId;
  // User? user;
  // CollectionReference usersList =
  // FirebaseFirestore.instance.collection('users');
  // List docIds = [];
  //
  // final docUser = FirebaseFirestore.instance.collection('user').doc();
  //
  // Stream<List<UserModel>> readUsers() {
  //   return FirebaseFirestore.instance.collection('user').snapshots().map(
  //       (snapshot) =>
  //           snapshot.docs.map((doc) => UserModel.fromJson(doc)).toList());
  // }


  // Stream<UserModel> readCurrentUser(String uid) {
  //   return FirebaseFirestore.instance
  //       .collection('user')
  //       .doc(uid)
  //       .snapshots()
  //       .map((doc) => UserModel.fromJson(doc));
  // }




  //
  // Future getDocIds() async {
  //   await usersList.get().then(
  //         (snapshot) =>
  //         snapshot.docs.forEach((document) {
  //           print(document.reference);
  //           docIds.add(document.reference.id);
  //         }),
  //   );
  // }

  @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       user = FirebaseAuth.instance.currentUser!;
  //     }
  //     getDocIds();
  //     setState(() {});
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVm>(builder: (context, authVm, child) => Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: R.colors.secondary,
          title: Text(
            'Home Page',
            style: R.textStyles.poppinsRegular(color: R.colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.back();
              },
              child: const Icon(Icons.logout),
            ),
            w2,
          ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h4,
            h3,
            // Expanded(
            //     child: FutureBuilder<UserModel>(
            //         future: authVm.readCurrentUser(authVm.userModel.id!),
            //         builder: (context, snapshot) {
            //           if (snapshot.data != null) {
            //             final data = snapshot.data!;
            //             // print(snapshot.data);
            //
            //             return SingleChildScrollView(child: show(data));
            //           }
            //           return const Center(
            //             child: CircularProgressIndicator(),
            //           );
            //         })),

            AppButton(
                buttonTitle: 'user_screen',
                textColor: R.colors.white,
                onTap: () {

                  Get.bottomSheet(
                    const MyUser(),
                    isScrollControlled: true,
                  );
                  setState(() {});
                }),
            h2,
            AppButton(
                buttonTitle: 'stream_builder',
                textColor: R.colors.white,
                onTap: () {

                  Get.bottomSheet(
                    const StreamView(),
                    isScrollControlled: true,
                  );
                  setState(() {});
                }),
            h2,
            AppButton(
                buttonTitle: 'future_builder',
                textColor: R.colors.white,
                onTap: ()  {
              Get.bottomSheet(const FutureView(),isScrollControlled: true);
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
