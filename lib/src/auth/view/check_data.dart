import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/base/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckUser extends StatelessWidget {
  static String route = "/checkUser";

  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context,snapshot) {
            if (snapshot.hasData) {
             return const HomeView();
            } else {
            return  const LoginView();
            }
          }),

    );
  }
}


