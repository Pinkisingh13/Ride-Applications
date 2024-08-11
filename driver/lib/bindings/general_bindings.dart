import 'package:driver/features/screens/controller/location_controller/location_controller.dart';
import 'package:get/get.dart';

import '../data/authentication/authentication.dart';
import '../utils/helpers/network_manager.dart';

//inside app.dart  we can call [initialBinding: GeneralBindings]
//Whenever application runs it will automatically triggers this generalBindings and initiate NetworkManager and once the instanse of NetworkManager created and initialized on the application run We can simply use [NetworkManager.instance] it is going to find the instance of that class.
class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(DriverLocationController());
  }
}
