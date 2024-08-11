import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/colors.dart';
import '../../../screens/view/home/home.dart';
import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  //  Variables
  final deviceStorage = GetStorage();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      screenRedirect();
    });
  }

  screenRedirect() {
    if (kDebugMode) {
      print("Get storage splash screen: ");
      print(deviceStorage.read('IsFirstTime'));
    }
    // Local Storage
    deviceStorage.writeIfNull('IsFirstTime', true);

    deviceStorage.read("IsFirstTime") != true
        ? Get.offAll(() => const HomeScreen())
        : Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: TColors.white,
      body: Center(
        child: Image(
          image: AssetImage(
            "assets/logos/app_logo.png",
          ),
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
