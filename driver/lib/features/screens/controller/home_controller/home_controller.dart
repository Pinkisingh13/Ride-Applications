import 'dart:async';
import 'dart:convert';
import 'package:driver/features/screens/view/trips/trips.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../data/authentication/authentication.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/pending_ride_model/pending_ride_model.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final toggle = true.obs;
  final RxList<Ride> rides = <Ride>[].obs;
  late Timer _timer;
  
  // Method to start the timer and call fetchingDrivers periodically
  void startFetching() async {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      bool isDataNotEmpty = await fetchingPendingRides();
      if (isDataNotEmpty) {
        // Stop the timer if data is fetched
        Get.to(() => const TripsScreen());
        _timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<bool> fetchingPendingRides() async {
    try {

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        throw Exception('Token is required');
      }

      // Calling Route
      final response = await http.get(
        Uri.parse('http://192.168.1.6:3000/driver/pending-rides'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      print(response);
      print(response.statusCode);

      // Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("data from line no: 71 is $data");

        print('data from line no: 73 is ${data['data']}');


        // Update the list of rides with the fetched data
        for (var rideJson in data['data']) {
          rides.add(Ride.fromJson(rideJson));
        }

        // Check if data is empty and return true if it is empty
        return data['data'].isNotEmpty;
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
        print("catch FetchPendingRidesException ===>: ${e.toString()}");
      }
      return false;
    }
  }
}
