import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/features/screens/controller/location_selector/location_controller.dart';
import 'package:user/features/screens/view/location_selector/location.dart';
import 'package:user/utils/constants/colors.dart';
import 'package:user/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              const Image(
                image: AssetImage("assets/images/user_banner2.png"),
                height: 230,
                fit: BoxFit.contain,
              ),

              /// Ride Options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select a ride",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 20, color: TColors.black),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections / 1.4,
                  ),
                  const Row(
                    children: [
                      HomeRideOptionsBox(
                          image: "assets/images/taxi.png", vehicleName: "Car"),
                      SizedBox(
                        width: TSizes.spaceBtwSections,
                      ),
                      HomeRideOptionsBox(
                          image: "assets/images/bike.png", vehicleName: "Bike"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeRideOptionsBox extends StatelessWidget {
  const HomeRideOptionsBox({
    super.key,
    required this.image,
    required this.vehicleName,
  });

  final String image;
  final String vehicleName;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.to(() => const LocationSelectorScreen());
        LocationSelectorController.instance.updateVehicleName(vehicleName);
      },
      icon: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(TSizes.xs),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[100],
            ),
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            vehicleName,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: TColors.black),
          )
        ],
      ),
    );
  }
}
