import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:user/features/screens/controller/location_selector/location_controller.dart';
import '../../../../data/authentication/authentication.dart';
import '../../../../utils/constants/images.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../view/requesting_ride/ride_request.dart';

class BookRideController extends GetxController {

  Future<void> sendRequestToBookRide(
      String pickupLocation,
      String dropOffLocation,
      String amount,
      String time,
      String distance) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialogue(
          "Processing...", ImageString.docerAnimation);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        throw Exception('Token is required');
      }

      // Data for Response Body
      final vehicleName = LocationSelectorController.instance.vehicleName.value;
      final body = {
        'origin': pickupLocation,
        'destination': dropOffLocation,
        'amount': amount,
        'time': time,
        'distance': distance,
        'vehicle_type': vehicleName,
      };
      // Calling Route
      final http.Response response = await http.post(
        Uri.parse('http://192.168.1.6:3000/trip/book-ride'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode(body),
      );

      //Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("BookRidedata===>$data");
        TFullScreenLoader.stopLoading();

        // Navigate to RideDetailScreen with the fetched waiter data
        Get.to(() => RideRequestScreen(
              id: data['data']['uid'].toString(),
              pickupLocation: pickupLocation,
              dropOffLocation: dropOffLocation,
              amount: data['data']['amount'].toString(),
              time: time,
              distance: distance,
            ),);
      } else {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackbar(
          title: 'Error',
          message: 'Failed to load data: ${response.statusCode}',
        );
        if (kDebugMode) {
          print('Failed to load waiter list: ${response.statusCode}');
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to load data: ${e.toString()}',
      );
      if (kDebugMode) {
        print("catch BookRideException ===>: ${e.toString()}");
      }
    }
  }
}
