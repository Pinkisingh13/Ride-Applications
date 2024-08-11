import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/common/widgets/appbar/appbar.dart';
import 'package:user/common/widgets/pick_and_drop/pickup_dropoff.dart';
import 'package:user/features/screens/controller/ride_details/book_ride_controller.dart';
import 'package:user/utils/constants/sizes.dart';
import 'package:user/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';

class RideDetailScreen extends StatelessWidget {
  const RideDetailScreen({
    super.key,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.distance,
    required this.amount,
    required this.time,
  });

  final String pickupLocation, dropOffLocation, distance, time, amount;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookRideController());
    return Scaffold(
      appBar: const PAppBar(title: "Ride details"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSizes.defaultSpace * 2,
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickUpAndDropOff(
                title: "Pick up",
                address: pickupLocation,
                image: "assets/images/pickup.png",
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              PickUpAndDropOff(
                title: "Drop off",
                address: dropOffLocation,
                image: "assets/images/drop_off.png",
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              Container(
                // height: 200,
                padding: const EdgeInsets.all(30),
                width: THelperFunctions.screenWidth(),
                decoration: BoxDecoration(
                  color: TColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage("assets/images/taxi.png"),
                          height: 50,
                        ),
                        Column(
                          children: [
                            const Text("Amount"),
                            Text(
                              "\u{20B9} $amount",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text("Distance"),
                            Text(
                              distance,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Time"),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const RideDetailsButtons()
                  ],
                ),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.sendRequestToBookRide(
                      pickupLocation,
                      dropOffLocation,
                      amount,
                      time,
                      distance,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          const Size(TSizes.elevatedButtonSpaceHeight, 0)),
                  child: const Text("Book"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideDetailsButtons extends StatelessWidget {
  const RideDetailsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: const Column(
            children: [
              Icon(Icons.money, color: TColors.darkGrey),
              SizedBox(
                height: TSizes.sm,
              ),
              Text("Cash"),
            ],
          ),
          onPressed: () {},
        ),
        TextButton(
          child: const Column(
            children: [
              Icon(Icons.discount, color: TColors.darkGrey),
              SizedBox(
                height: TSizes.sm,
              ),
              Text("Promo code"),
            ],
          ),
          onPressed: () {},
        ),
        TextButton(
          child: const Column(
            children: [
              Icon(
                Icons.more_horiz,
                color: TColors.darkGrey,
              ),
              SizedBox(
                height: TSizes.sm,
              ),
              Text("Options"),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
