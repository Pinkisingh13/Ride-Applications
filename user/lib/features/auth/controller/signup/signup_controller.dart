import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/authentication/authentication.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/signup/signup_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // -- Varibles --
  final togglePassword = true.obs;
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // -- Signup --
  Future<void> signup() async {
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
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      AuthenticationRepository.instance.signup(
        UserSignup(
          fullname: fullname.text,
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
