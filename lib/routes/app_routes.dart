
import 'package:demo_firebase/src/auth/view/check_data.dart';
import 'package:demo_firebase/src/auth/view/demo.dart';
import 'package:demo_firebase/src/auth/view/forgetpass_view.dart';
import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/auth/view/otp_view.dart';
import 'package:demo_firebase/src/auth/view/signup_view.dart';
import 'package:demo_firebase/src/base/view/chat_view.dart';
import 'package:demo_firebase/src/base/view/chat_detailview.dart';
import 'package:demo_firebase/src/base/view/home_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';


abstract class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: HomeView.route, page: () => const HomeView()),
    GetPage(name: CheckUser.route, page: () => const CheckUser()),
    GetPage(name: LoginView.route, page: () => const LoginView()),
    GetPage(name: SignupView.route, page: () => const SignupView()),
    GetPage(name: ForgetPass.route, page: () => const ForgetPass()),
    GetPage(name: Demo.route, page: () => const Demo()),
    GetPage(name: ChatView.route, page: () => const ChatView()),
    GetPage(name: OTPVerificationView.route, page: () => const OTPVerificationView()),
    // GetPage(name: ChatDetail.route, page: () => const ChatDetail()),
  ];
}
