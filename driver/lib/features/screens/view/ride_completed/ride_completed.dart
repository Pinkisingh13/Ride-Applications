import 'package:driver/common/widgets/appbar/appbar.dart';
import 'package:driver/features/screens/view/trips/widgets/pickup_dropoff.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:driver/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../model/pending_ride_model/pending_ride_model.dart';

class RideCompletedScreen extends StatelessWidget {
  const RideCompletedScreen({super.key, required this.rides});
  final Ride rides;
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
                height: TSizes.spaceBtwSections,
              ),
              Text(
                "Please Recieve Your cash",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              const Divider(),
              Container(
                width: THelperFunctions.screenWidth() / 2,
                child: Column(
                  children: [
                    PickUpAndDropOff(
                      title: "Pick up",
                      address: rides.origin,
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    PickUpAndDropOff(
                      title: "Drop off",
                      address: rides.destination,
                    ),
                    SizedBox(
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
                      "\u{20B9} ${rides.amount}",
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
