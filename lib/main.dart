import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_firebase/resources/localization/app_localization.dart';
import 'package:demo_firebase/resources/resources.dart';
import 'package:demo_firebase/routes/app_routes.dart';
import 'package:demo_firebase/src/auth/view/check_data.dart';
import 'package:demo_firebase/src/auth/view/login_view.dart';
import 'package:demo_firebase/src/auth/view_model/auth_vm.dart';
import 'package:demo_firebase/utils/no_internet_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  await Firebase.initializeApp();


  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthVm()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {}


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _connectionStatus = "Unknown";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setLocale(const Locale("en"));
      startConnectionStream();
    });
  }

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: GetMaterialApp(
          title: 'demo',
          locale: _locale,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          fallbackLocale: const Locale('en', 'US'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          localeResolutionCallback:
              (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          getPages: AppRoutes.pages,
          initialRoute: LoginView.route,
          theme: ThemeData(
              primaryColor: R.colors.primary,
              dividerColor: R.colors.transparent
            // textTheme: TextTheme(
            //   titleMedium: GoogleFonts.bitter(
            //       fontSize: 12.sp, color: R.colors.themeColor),
            // ),
            // textSelectionTheme: TextSelectionThemeData(
            //   cursorColor: R.colors.themeColor,
            //   selectionColor: R.colors.themeColor,
            //   selectionHandleColor: R.colors.themeColor,
            // ),
          ),
        ),
      );
    });
  }


  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          debugPrint(result.toString());
          debugPrint(_connectionStatus);
        }
        break;
      case ConnectivityResult.mobile:
        {
          debugPrint(result.toString());
        }
        break;
      case ConnectivityResult.none:
        {
          Get.snackbar(LocalizationMap.getValue("uh_oh"),
              LocalizationMap.getValue("no_internet_connection"));
          Get.to(() => const NoInternetScreen());
        }
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        break;
    }
  }

  void startConnectionStream() {
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
}

