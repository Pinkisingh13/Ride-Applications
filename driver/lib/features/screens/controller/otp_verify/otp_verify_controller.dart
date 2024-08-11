import 'dart:convert';

import 'package:driver/features/screens/view/ride_start/ride.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../data/authentication/authentication.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/pending_ride_model/pending_ride_model.dart';

class OtpVerificationController extends GetxController {
  final pinController = TextEditingController();
  GlobalKey<FormState> pinPutFormKey = GlobalKey<FormState>();

  Future<void> verifyOtp(String id, Ride rides) async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialogue(
          "Verifying Otp...", ImageString.docerAnimation);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Form Validation
      if (!pinPutFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        TFullScreenLoader.stopLoading();
        throw Exception('Token is required');
      }

      // Calling Route
      final response = await http.post(
        Uri.parse('http://192.168.1.6:3000/driver/verify-otp/$id'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: json.encode({'otp': pinController.text}),
      );

      print(response);
      print(response.statusCode);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("data from line no: 44 is $data");
        if (data['code'] == 200) {
          //  Move to the Screen
          TFullScreenLoader.stopLoading();
          Get.to(() => RideStartDetailScreen(
                rides: rides,
                id: id,
              ));
        }else{
           TFullScreenLoader.stopLoading();
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Error from if else: ${data['code']}',
        );
        if (kDebugMode) {
          print('Failed to load : ${response.statusCode}');
        }
        }
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Error with: ${response.statusCode}',
        );
        if (kDebugMode) {
          print('Failed to load : ${response.statusCode}');
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to load data: ${e.toString()}',
      );
      if (kDebugMode) {
        print("catch OtpVerificationException ===>: ${e.toString()}");
      }
    }
  }
}
