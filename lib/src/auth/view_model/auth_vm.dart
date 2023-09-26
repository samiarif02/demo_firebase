import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/src/auth/model/user_model.dart';
import 'package:demo_firebase/src/base/view/home_view.dart';
import 'package:demo_firebase/utils/bot_toast/zbot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view/login_view.dart';

class AuthVm extends ChangeNotifier {

  UserModel userModel = UserModel();
  bool otpFieldVisibility = false;
  var receivedID = '';


  Future<void> createUser(UserModel user, String confirmPwd) async {
    final u = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email ?? "", password: confirmPwd);
    if (u.user != null) {
      await u.user?.sendEmailVerification().timeout(
          const Duration(seconds: 30));
      user.id = u.user?.uid;
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('user').doc(u.user?.uid);
      log(" model after  ${u.user?.uid}");
      await documentReference.set(user.toJson());
      ZBotToast.showToastSuccess(
          message: 'Your Account is Created! Please Login To your Account');
    }

    Get.offAndToNamed(LoginView.route);
  }

  Future<void> verifyPhoneNumber(String phoneNum) async {
    final auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 35),
        verificationCompleted:
            (PhoneAuthCredential phoneCred) async {
         await auth.signInWithCredential(phoneCred).then((value) {
           ZBotToast.showToastSuccess(message: 'Logged In Successfully');

           Get.toNamed(HomeView.route);
         });
        },
        verificationFailed: (error) {
          ZBotToast.showToastError(message: error.message);
          print(error.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          receivedID = verificationId;
          otpFieldVisibility = true;
          update();
          },

        codeAutoRetrievalTimeout: (String verificationId) {
          ZBotToast.showToastError(message: 'TimeOut');
        },
    );
  }

  Future<void> verifyOTPCode(String otp) async {
    final auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: otp,
    );
    print(receivedID);
    await auth
        .signInWithCredential(credential)
        .then((value) {
      ZBotToast.showToastSuccess(message: 'Logged In Successfully');
      print('User Login In Successful');
      Get.toNamed(HomeView.route);
    });
  }

  Future loginIn(String email, String password) async {
    final userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);

    if (userCred.user != null) {
      log("==== ${userCred.user?.uid}");
      if (userCred.user?.emailVerified == true) {
        await getCurrentUser(userCred.user?.uid ?? "");
        Get.toNamed(HomeView.route);
      }


      else {
        await userCred.user?.sendEmailVerification().timeout(
            const Duration(seconds: 30));
        ZBotToast.showToastError(
            message: "Your email is not verified please verify your email to continue");
      }
    }
  }


  Future<void> getCurrentUser(String uid) async {
    var doc = await FirebaseFirestore.instance.collection("user")
        .doc(uid)
        .get();
    print("USER $doc");
    userModel = UserModel.fromJson(doc.data());
  }

  Future<void> updateUser(UserModel userModel) async {
    await FirebaseFirestore.instance.collection("user").doc(userModel.id).set(
        userModel.toJson(),
        SetOptions(merge: true));
    ZBotToast.showToastSuccess(message: 'Your Name is Updated!');
    notifyListeners();
  }

  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
    FirebaseAuth.instance.signOut();
    ZBotToast.showToastSuccess(message: 'Your Account is deleted!');

    notifyListeners();
  }


  Future<UserModel> readFutureUser(String uid) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get();

    if (docSnapshot.exists) {
      final userData = UserModel.fromJson(
          docSnapshot.data() as Map<String, dynamic>);
      return userData;
    } else {
      throw Exception(
          "User not found"); // You can customize the error handling as needed.
    }
  }

  Stream<UserModel> readStreamUser(String uid) {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromJson(doc));
  }


  Future<List<UserModel>> readFutureAllUser() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .get();

    if (docSnapshot.docs.isNotEmpty) {
      final userData = docSnapshot.docs.map((e) => UserModel.fromJson(e.data()))
          .toList();
      return userData;
    } else {
      throw Exception("User not found");
    }
  }

  Stream<List<UserModel>> readStreamAllUsers() {
    return FirebaseFirestore.instance.collection('user').snapshots().map(
            (snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromJson(doc)).toList());
  }

  Future<bool> changePassword(String newPassword, String oldPassword) async {
    bool proceed = false;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      UserCredential result;
      AuthCredential credentials =
      EmailAuthProvider.credential(
          email: userModel.email ?? "", password: oldPassword);
      if (user != null) {
        result = await user.reauthenticateWithCredential(credentials);
        if (result.user != null) await user.updatePassword(newPassword);
        log("Password changed successfully!");
        ZBotToast.showToastSuccess(
            message: "password_updated_successfully".L());
        proceed = true;
      } else {
        proceed = false;
        log("password does not match.");
      }

      /// for commit
    } catch (e) {
      proceed = false;
      ZBotToast.showToastError(message: e
          .toString()
          .split('] ')
          .last);

      log("Error changing password: $e");
    }
    return proceed;
  }

  update(){
    notifyListeners();
  }

}