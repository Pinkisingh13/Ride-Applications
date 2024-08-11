import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:user/features/screens/view/ride_completed/ride_completed.dart';

import '../../../../data/authentication/authentication.dart';
import '../../../../utils/popups/loaders.dart';

class RideStartedController extends GetxController{

   late Timer _timer;
  void startFetchingRideCompleted(String id, String pickupLocation, String dropOffLocation, String amount) async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isStatusMatched = await moveToTheRideCompleted(id);
      if (isStatusMatched) {
        // Stop the timer if data is fetched
        Get.to(
          () => RideCompletedScreen(pickupLocation: pickupLocation, dropOffLocation: dropOffLocation),
        );
        _timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<bool> moveToTheRideCompleted(String id) async {
    try {

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        // TFullScreenLoader.stopLoading();
        throw Exception('Token is required');
      }

      // Calling Route
      final response = await http.get(
        Uri.parse('http://192.168.1.6:3000/trip/get-trip/$id'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // final status = data['data'];
        // print(status)/;
        print(
            "data from line no: 56 && from moveTOTHERIDESATRTEDFunction is $data");
        print(data['data']);
        print(data['data']['tripStatus']);
        // print(data)

        return data['data']['tripStatus'] == "completed";
        // return true;
      } else {
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Failed: Error: ${response.statusCode}',
        );
        if (kDebugMode) {
          print('Failed to load : ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      // TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to load data: ${e.toString()}',
      );
      if (kDebugMode) {
        print("catch RideCompletedException ===>: ${e.toString()}");
      }
      return false;
    }
  }
}