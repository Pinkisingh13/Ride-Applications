import 'package:driver/utils/popups/loaders.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class DriverLocationController extends GetxController {
  static DriverLocationController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  var location = 'We are fetching your current location'.obs;

  Future<void> getCurrentLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    try {
    
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      TLoaders.warningSnackbar(title: "Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        TLoaders.warningSnackbar(title: "Location permissions are denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      TLoaders.warningSnackbar(
          title:
              "Location permissions are permanently denied, we cannot request permissions.");
      return;
    }

    // permissions are granted
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      location.value =
          ' ${placemark.street} , ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode},${placemark.administrativeArea}, ${placemark.country}';
    } else {
      TLoaders.customToast(message: "Can't fetch your location");
    }
    } catch (e) {
       TLoaders.errorSnackbar(
        title: 'Error',
        message: 'Failed to fetch location: ${e.toString()}',
      );
      location.value = 'Failed to fetch location.';
    }

  }
}
