import 'dart:convert';

import 'package:driver/features/screens/view/ride_completed/ride_completed.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/authentication/authentication.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/pending_ride_model/pending_ride_model.dart';


class RideCompletedController extends GetxController {

  Future<void> rideCompleted(String id, Ride rides) async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialogue(
          "Ride Completed Successfully", ImageString.docerAnimation);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        TFullScreenLoader.stopLoading();
        throw Exception('Token is required');
      }

      // Calling Route
      final response = await http.post(
        Uri.parse('http://192.168.1.6:3000/driver/ride-completed/$id'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      print(response);
      print(response.statusCode);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("data from line no: 44 is $data");

        //  Move to the Screen
        TFullScreenLoader.stopLoading();
        Get.to(() => RideCompletedScreen(
               rides: rides,        
            ),);
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
