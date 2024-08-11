import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/widgets/appbar/appbar.dart';
import 'package:user/common/widgets/pick_and_drop/pickup_dropoff.dart';
import 'package:user/features/screens/controller/fetching_driver/fetching_driver_controller.dart';
import 'package:user/utils/constants/colors.dart';
import 'package:user/utils/constants/sizes.dart';

import '../../../../utils/helpers/helper_functions.dart';

class RideRequestScreen extends StatelessWidget {
  const RideRequestScreen(
      {super.key,
      required this.pickupLocation,
      required this.dropOffLocation,
      required this.id,
      required this.amount,
      required this.time,
      required this.distance,
      });

  final String pickupLocation, dropOffLocation, amount, time, distance;
  final String id;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FetchingDriverController());

    // Start fetching when the screen is built
    controller.startFetching(id, pickupLocation, dropOffLocation,amount, time,distance);
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: const PAppBar(title: "Requesting Ride"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickUpAndDropOff(
                title: "Pick up Location",
                address: pickupLocation,
                image: "assets/images/pickup.png",
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Drop off
              PickUpAndDropOff(
                title: "Drop off Location",
                address: dropOffLocation,
                image: "assets/images/drop_off.png",
              ),

              Lottie.asset(
                "assets/animations/search_loading.json",
                backgroundLoading: true,
                onLoaded: (p0) {},
                repeat: true,
                fit: BoxFit.contain,
                height: THelperFunctions.screenHeight() / 2,
                width: THelperFunctions.screenWidth(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 