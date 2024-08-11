import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/features/screens/controller/waiting_for_Driver/waiting_for_driver_controller.dart';
import 'package:user/utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/pick_and_drop/pickup_dropoff.dart';
import '../../../../utils/constants/colors.dart';

class WaitingForDriverScreen extends StatelessWidget {
  const WaitingForDriverScreen({
    super.key,
    required this.id,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.amount,
    required this.otp,
  });

  final String id;
  final String pickupLocation;
  final String dropOffLocation, amount,
  otp;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WaitingForDriverController());

    Timer.periodic(const Duration(seconds: 4), (timer) {
      controller.startFetching(id, pickupLocation, dropOffLocation, amount, otp);
      timer.cancel();
    });

    return Scaffold(
      appBar: const PAppBar(
        title: '',
      ),
      body: Column(
        children: [
          ReusableUserWaitingScreen(
            text: "Driver is on the way",
            amount: amount,
            dropOffLocation: dropOffLocation,
            pickupLocation: pickupLocation,
            otp: otp,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationContainer(
        amount: amount,
        dropOffLocation: dropOffLocation,
        pickupLocation: pickupLocation,

        otp: otp,
      ),
    );
  }
}

class BottomNavigationContainer extends StatelessWidget {
  const BottomNavigationContainer({
    super.key,
    this.isShowMiddleButton = false,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.amount,
    required this.otp,
  });

  final bool isShowMiddleButton;
  final String pickupLocation, dropOffLocation, amount, otp;
  // otp;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(FetchingDriverController());
    // final details = controller.tripDetails;

    return Container(
      height: kBottomNavigationBarHeight * 2,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
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
            address: '\u{20B9}$amount',
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
                    side: BorderSide(color: Colors.red[200]!),
                    fixedSize: const Size.fromWidth(100),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    backgroundColor: Colors.red[400],
                  ),
                  onPressed: () {
                    // Get.to(() => const RideCompletedScreen());
                  },
                  child: Text(
                    "Cancel",
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
                  // address: otp ?? 'N/A',
                  address: otp,
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

class ReusableUserWaitingScreen extends StatelessWidget {
  const ReusableUserWaitingScreen({
    super.key,
    required this.text,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.amount,
    required this.otp,
  });

  final String text, pickupLocation, dropOffLocation, amount,otp;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      radius: 23,
                      child: const Image(
                        image: AssetImage("assets/images/user2.png"),
                      ),
                    ),
                    const SizedBox(
                      width: TSizes.spaceBtwItems,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Driver Name",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.grey.withOpacity(0.4)),
                          ),
                          const SizedBox(
                            height: TSizes.xs,
                          ),
                          Text(
                            "Sankar Singh",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.call,
                        color: TColors.blueDarkShade,
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.blue[100]),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PickUpAndDropOff(
                  title: "Pick up",
                  address: pickupLocation,
                  titleTextStyle:
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 207, 207, 207),
                          ),
                  image: "assets/images/pickup.png",
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                Text(
                  "Arrives in",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      fontSize: 12),
                ),
                const SizedBox(
                  height: TSizes.xs,
                ),
                const Text(
                    "2 min"), // This should be dynamic based on actual data
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Drop off
                PickUpAndDropOff(
                  title: "Drop off",
                  address: dropOffLocation,
                  titleTextStyle:
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 207, 207, 207),
                          ),
                  image: "assets/images/drop_off.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
