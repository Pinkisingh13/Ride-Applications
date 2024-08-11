import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user/data/authentication/authentication.dart';
import 'package:user/features/screens/view/waiting_for_driver/waiting_for_driver.dart';
import 'package:user/utils/popups/loaders.dart';

class FetchingDriverController extends GetxController {
  static FetchingDriverController get instance => Get.find();

  // Reactive variable to track if data is fetched
  // final RxList<Map<String, dynamic>> tripDetails = <Map<String, dynamic>>[].obs;
  late Timer _timer;

  // Method to start the timer and call fetchingDrivers periodically
  void startFetching(
      String id, String pickupLocation, String dropOffLocation, String amount, String time, String distance) {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      bool isDataEmpty = await fetchingDrivers(id);
      if (isDataEmpty) {
        // Stop the timer if data is fetched
        getRideinfo(id, pickupLocation, dropOffLocation, amount, time, distance);
        _timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> getRideinfo(String id, String pickupLocation,
      String dropOffLocation, String amount, String time, String distance) async {
    print(pickupLocation);
    print(dropOffLocation);
    try {
      // Calling Route
      final response = await http.get(
        Uri.parse('http://192.168.1.6:3000/trip/get-trip/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("GetRideInfoData===>: $data");

        // Navigate to RideDetailScreen with the fetched driver data
        Get.to(
          () => WaitingForDriverScreen(
            id: id,
            pickupLocation: pickupLocation,
            dropOffLocation: dropOffLocation,
            amount: amount,
            otp: data['data']['otp'],    
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
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to load data: ${e.toString()}',
      );
      if (kDebugMode) {
        print(
            "catch GetInfoExceptionFromFetchinController ===>: ${e.toString()}");
      }
    }
  }

  Future<bool> fetchingDrivers(String id) async {
    try {
      print(id);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        throw Exception('Token is required');
      }

      // Calling Route
      final response = await http.get(
        Uri.parse('http://192.168.1.6:3000/trip/requesting-ride/$id'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      print(response);
      print(response.statusCode);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("data from line no: 68 is $data");

        print('data from line no: 70 is ${data['data']}');
        // Check if data is empty and return true if it is empty
        return data['data'].isEmpty;
      } else {
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'We are fetching..: ${response.statusCode}',
        );
        if (kDebugMode) {
          print('Failed to load : ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
  
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
