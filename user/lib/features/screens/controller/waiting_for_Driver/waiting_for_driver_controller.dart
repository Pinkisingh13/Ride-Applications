import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user/features/screens/view/ride_started/ride_started.dart';
import '../../../../data/authentication/authentication.dart';
import '../../../../utils/popups/loaders.dart';

class WaitingForDriverController extends GetxController {
  late Timer _timer;
  void startFetching(
      String id, String pickupLocation, String dropOffLocation, String amount, String otp) async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      bool isStatusMatched = await moveToTheRideStarted(id);
      if (isStatusMatched) {
        // Stop the timer if data is fetched
        Get.to(
          () => RideStartedScreen(
            id: id,
            pickupLocation: pickupLocation,
            dropoffLocation: dropOffLocation,
            amount: amount,
            otp: otp,
          ),
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

  Future<bool> moveToTheRideStarted(String id) async {
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
        print(
            "data from line no: 58 && from moveTOTHERIDESATRTEDFunction is $data");
        print(data['data']);
        print(data['data']['tripStatus']);
        // print(data)

        return data['data']['tripStatus'] == "started";
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
        print("catch FetchDriverException ===>: ${e.toString()}");
      }
      return false;
    }
  }
}
