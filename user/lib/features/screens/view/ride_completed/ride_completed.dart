import 'package:user/common/widgets/appbar/appbar.dart';
import 'package:user/utils/constants/sizes.dart';
import 'package:user/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/pick_and_drop/pickup_dropoff.dart';

class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen(
      {super.key, required this.pickupLocation, required this.dropOffLocation});

  final String pickupLocation;
  final String dropOffLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PAppBar(title: "Ride Completed"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ride Completed Successfully",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 23,
                      color: Colors.green[500],
                    ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              Text(
                "Pay Cash to the driver",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const Divider(),
              SizedBox(
                width: THelperFunctions.screenWidth() / 2,
                child: Column(
                  children: [
                    PickUpAndDropOff(title: "Pick up", address: pickupLocation),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    PickUpAndDropOff(
                      title: "Drop off",
                      address: dropOffLocation,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: THelperFunctions.screenWidth() / 1.30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Cash",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Text(
                      "\u{20B9} 1133",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
