import 'package:driver/data/authentication/authentication.dart';
import 'package:driver/utils/helpers/network_manager.dart';
import 'package:driver/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/images.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/login/login_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // -- Varibles --
  final togglePassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // -- Login--
  Future<void> login() async {
    try {
      TFullScreenLoader.openLoadingDialogue(
          "We are processing your information...", ImageString.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      
      AuthenticationRepository.instance.login(
        LoginData(
          email: email.text,
          password: password.text,
        ),
      );
    } catch (e) {
      // Show some generic error to the user
      TLoaders.errorSnackbar(title: "Oh Snap!", message: e.toString());
      TFullScreenLoader.stopLoading();
    }
  }
}
