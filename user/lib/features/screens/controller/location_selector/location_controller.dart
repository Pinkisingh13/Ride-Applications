import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:user/data/authentication/authentication.dart';
import 'package:user/utils/constants/images.dart';
import 'package:user/utils/popups/full_screen_loader.dart';
import 'package:http/http.dart' as http;
import 'package:user/utils/popups/loaders.dart';
import '../../model/location/location_model.dart';
import '../../view/ride_details/ride_details.dart';

class LocationSelectorController extends GetxController {
  static LocationSelectorController get instance => Get.find();

  final pickupLocation = TextEditingController();
  final dropOffLocation = TextEditingController();
  GlobalKey<FormState> locationFormKey = GlobalKey<FormState>();
  final RxList<PlaceSuggestion> locationDetails = <PlaceSuggestion>[].obs;
  final activeField = ''.obs;

  // Reactive variable to store vehicleName
  var vehicleName = ''.obs;

  void updateVehicleName(String name) {
    vehicleName.value = name;
  }

  Future<void> placeLocation(String query) async {
    Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json', //unencoder path

        {
          "input": query,
          "key": dotenv.env["API_KEY"]!,
        });
// Making Get Request
    String? response = await fetchUrl(uri);

    if (response != null) {
      final parsedResponse = jsonDecode(response);

      if (parsedResponse != null) {
        final suggestions = (parsedResponse['predictions'] as List)
            .map((json) => PlaceSuggestion.fromJson(json))
            .toList();
        locationDetails.value = suggestions;
      }

      print("PlaceLocationFunction ====> $response");
    }
  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;

  }
 void setActiveField(String field) {
    activeField.value = field;
  }

   void selectLocationFromList(String description) {
    if (activeField.value == 'pickup') {
      pickupLocation.text = description;
    } else if (activeField.value == 'dropoff') {
      dropOffLocation.text = description;
    }
    locationDetails.clear();
  }
  Future<void> selectLocation() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialogue(
          "Calculating Fair..", ImageString.docerAnimation);

      // Fetch Token
      final token = await AuthenticationRepository.instance.getToken();

      // Make sure the token is not null or empty
      if (token == null || token.isEmpty) {
        throw Exception('Token is required');
      }

      // Validate Form
      if (!locationFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final body = {
        'origin': pickupLocation.text,
        'destination': dropOffLocation.text,
      };
      // Calling Route
      final http.Response response = await http.post(
        Uri.parse('http://192.168.1.6:3000/trip/get-fare'),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
        body: jsonEncode(body), 
      );

      //Check response Status Code
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        // Check if any of the response data is null and handle it
        final amount = data['data']['amount'] ?? 'N/A';
        final time = data['data']['time'] ?? 'N/A';
        final distance = data['data']['distance'] ?? 'N/A';

        TFullScreenLoader.stopLoading();

        // Navigate to RideDetailScreen with the fetched waiter data
        Get.to(
          () => RideDetailScreen(
            amount: amount,
            time: time,
            distance: distance,
            pickupLocation: pickupLocation.text,
            dropOffLocation: dropOffLocation.text,
          ),
        );
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
        print("catch LocationControllerException ===>: ${e.toString()}");
      }
    }
  }
}
