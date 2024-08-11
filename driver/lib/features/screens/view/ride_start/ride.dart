import 'package:driver/common/widgets/appbar/appbar.dart';
import 'package:driver/features/screens/controller/ride_completed/ride_completed_controller.dart';
import 'package:driver/features/screens/view/trips/widgets/pickup_dropoff.dart';
import 'package:driver/utils/constants/colors.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/pending_ride_model/pending_ride_model.dart';

class RideStartDetailScreen extends StatelessWidget {
  const RideStartDetailScreen({super.key, required this.rides, required this.id});

  final Ride rides;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PAppBar(
        title: "Ride Started",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickUpAndDropOff(
                title: "Pick up",
                address: rides.origin,
                image: "assets/images/pickup.png",
                isShowImage: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                "Drop off by",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      fontSize: 12,
                    ),
              ),
              const SizedBox(
                height: TSizes.xs,
              ),
              const Text("2 min"),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              PickUpAndDropOff(
                title: "Drop off",
                address: rides.destination,
                image: "assets/images/drop_off.png",
                isShowImage: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections * 2,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        radius: 25,
                        child: const Image(
                          image: AssetImage("assets/images/user2.png"),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                          child: Text(
                        "Kritika Koria",
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                      IconButton(
                        icon: const Icon(
                          Icons.call,
                          color: TColors.blueDarkShade,
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: Colors.blue[50]),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationContainer(
        isShowMiddleButton: true,
        rides: rides,
        id: id,
      ),
    );
  }
}

class BottomNavigationContainer extends StatelessWidget {
  const BottomNavigationContainer({
    super.key,
    this.isShowMiddleButton = false,
    required this.rides,
    required this.id,
  });

  final bool isShowMiddleButton;
  final Ride rides;
  final String id;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RideCompletedController());
    return Container(
      height: kBottomNavigationBarHeight * 2,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      // constraints: const BoxConstraints(minHeight: 130, ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PickUpAndDropOff(
            alignment: CrossAxisAlignment.center,
            title: "Amount",
            address: "\u{20B9}${rides.amount}",
            titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: TColors.blueDarkShade,
                ),
            textStyle2: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.darkerGrey,
                ),
          ),
          isShowMiddleButton
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.green[200]!),
                    fixedSize: const Size.fromWidth(120),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    backgroundColor: Colors.green[400],
                  ),
                  onPressed: () {
                    controller.rideCompleted(id, rides);
                  },
                  child: Text(
                    "Ride Completed",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: TColors.white),
                  ),
                )
              : PickUpAndDropOff(
                  alignment: CrossAxisAlignment.center,
                  isShowImage: false,
                  title: "OTP",
                  address: "12345",
                  titleTextStyle:
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: TColors.blueDarkShade,
                          ),
                  textStyle2: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                ),
          PickUpAndDropOff(
            alignment: CrossAxisAlignment.center,
            title: "Payment",
            address: "Cash",
            isShowImage: false,
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: TColors.blueDarkShade),
            textStyle2: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColors.darkerGrey,
                ),
          ),
        ],
      ),
    );
  }
}
