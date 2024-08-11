import 'package:driver/features/screens/controller/home_controller/home_controller.dart';
import 'package:driver/features/screens/controller/location_controller/location_controller.dart';
import 'package:driver/features/screens/view/trips/trips.dart';
import 'package:driver/utils/constants/colors.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:driver/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/authentication/authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    controller.startFetching();
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: TColors.blueDarkShade,
          systemNavigationBarColor: TColors.blueDarkShade,
          systemNavigationBarDividerColor: TColors.blueDarkShade,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Container(
          width: 220,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Offline",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch.adaptive(
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.red[100],
                value: true,
                onChanged: (value) {},
              ),
              const Text(
                "Online",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationRepository.instance.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.appBarHeight,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: TSizes.sm,
                    ),
                    Text(
                      "Your Current Location",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey[500]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Obx(
                  () =>  Text(DriverLocationController.instance.location.value),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Lottie.asset("assets/animations/search_loading.json",
                    backgroundLoading: true,
                    repeat: true,
                    fit: BoxFit.contain,
                    height: THelperFunctions.screenHeight() / 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
