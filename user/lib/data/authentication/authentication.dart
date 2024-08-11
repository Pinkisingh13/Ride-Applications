import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/features/auth/view/login/login.dart';
import 'package:user/utils/popups/full_screen_loader.dart';
import '../../features/auth/model/login/login_model.dart';
import '../../features/auth/model/signup/signup_model.dart';
import '../../features/screens/view/home/home.dart';
import '../../utils/popups/loaders.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

// Varibles
  final storage = GetStorage();

  /// ---- Helper Function ----
  /// Token
  Future<void> setToken(String token) async {
    SharedPreferences data = await SharedPreferences.getInstance();
    await data.setString('x-auth-token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getString('x-auth-token');
  }

  // Sign up
  Future<void> signup(UserSignup user) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://192.168.1.6:3000/user/register'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        // Show success message
        TLoaders.successSnackbar(title: 'Successfully registered');
        TFullScreenLoader.stopLoading();
        // Move to Login Screen
        Get.offAll(() => const LoginScreen());
      } else {
        print("failed");
      }
    } catch (e) {
      print("catch authentication: ${e.toString()}");
      TFullScreenLoader.stopLoading();
    }
  }

  // Login
  Future<void> login(LoginData user) async {
    try {
      http.Response response = await http.post(
        Uri.parse('http://192.168.1.6:3000/user/login'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(user.toJson()),
      );

      // Check if the response status code is 200
      if (response.statusCode == 200) {
        // Decode the response body
        final data = jsonDecode(response.body);

        // Check if the response body contains a 'code' field
        if (data['code'] == 200) {

          // Set the Token
          String token = response.headers['x-auth-token'] ?? "";
          await setToken(token);

          // Set 'IsFirstTime' in storage to false
          storage.write('IsFirstTime', false);

          if (kDebugMode) {
            print("Authentication screen");
            print(storage.read('IsFirstTime'));
          }

          // Show success message
          TLoaders.successSnackbar(title: 'Successfully registered');

          // Stop Loading
          TFullScreenLoader.stopLoading();

          // Move to Home Screen
          Get.offAll(() => const HomeScreen());
        } else {
          // Handle the case when 'code' is not 200
          print("Login failed with code========> ${data['code']}");
          TLoaders.errorSnackbar(
              title: "Login Failed",
              message: "Invalid credentials or server error");
          TFullScreenLoader.stopLoading();
        }
      } else {
        // Handle the case when response status code is not 200
        print("HTTP request failed with status code: ${response.statusCode}");
        TLoaders.errorSnackbar(
            title: "Login Failed", message: "Server error. Please try again.");
        TFullScreenLoader.stopLoading();
      }
    } catch (e) {
      // Catch any exceptions and show an error message
      print("catch authentication: ${e.toString()}");
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Logout function
  Future<void> logout() async {
    try {
      // Clear all stored data in GetStorage and SharedPreferences
      await storage.erase();

      // Navigate to the login screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      // Handle any errors here, such as showing a snackbar
      Get.snackbar('Error', 'Failed to log out: $e');
    }
  }
}
