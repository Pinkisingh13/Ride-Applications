import 'dart:convert';
import 'package:driver/features/screens/controller/location_controller/location_controller.dart';
import 'package:driver/features/screens/view/confirm_pickup/confirm_ride.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../data/authentication/authentication.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/pending_ride_model/pending_ride_model.dart';

class TripAcceptController extends GetxController {
  Future<void> acceptingRides(String id, Ride rides) async {
    try {
      print("UID====> $id");
      // Start Loading
      TFullScreenLoader.openLoadingDialogue(
          "Fetching Drivers...", ImageString.docerAnimation);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        TFullScreenLoader.stopLoading();
        throw Exception('Token is required');
      }

      //Fetch Driver Location
      final location = DriverLocationController.instance.location.value;

      // Calling Route
      final response = await http.post(
        Uri.parse('http://192.168.1.6:3000/driver/accept-ride/$id'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: jsonEncode(
          {'location': location},
        ),
      );

      print(response);
      print(response.statusCode);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("data from line no: 44 is $data");

        print('data from line no: 46 is ${data['data']}');

        //  Move to the Screen
        TFullScreenLoader.stopLoading();
        Get.to(
          () => ConfirmRideScreen(
            rides: rides,
          ),
        );
      } else {
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'We are fetching..: ${response.statusCode}',
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
        print("catch AcceptRidesException ===>: ${e.toString()}");
      }
    }
  }
}
