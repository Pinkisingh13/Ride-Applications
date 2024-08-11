import 'package:driver/common/widgets/appbar/appbar.dart';
import 'package:driver/features/screens/view/otp_verify/otp_verify.dart';
import 'package:driver/features/screens/view/trips/widgets/accept_reject_buttons.dart';
import 'package:driver/features/screens/view/trips/widgets/pickup_dropoff.dart';
import 'package:driver/features/screens/view/trips/widgets/ride_details.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:driver/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/pending_ride_model/pending_ride_model.dart';

class ConfirmRideScreen extends StatelessWidget {
  const ConfirmRideScreen({super.key, required this.rides});

  final Ride rides;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PAppBar(
        title: "Confirm Ride",
      ),
      body: SizedBox(
        height: THelperFunctions.screenHeight(),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(TSizes.defaultSpace * 1.80),
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
                    height: TSizes.spaceBtwSections*1.50,
                  ),
                   PickUpAndDropOff(
                    title: "Drop off",
                    address: rides.destination,
                    image: "assets/images/drop_off.png",
                    isShowImage: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 2.40,
                  ),
                   RideDetailsContainer(
                    isShowName: true, 
                     rides: rides,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections * 1.60,
                  ),
                  

                  AcceptAndRejectButtons(
                    onTapAccept: () {
                      Get.to(() =>  OtpVerifyScreen( id: rides.uid, rides: rides),);
                    },
                    onTapReject: () {},
                    text1: "Confirm ",
                    text2: "Cancel",
                  
                    width: 100,
                    topPadding: 10,
                    bottomPaddidng: 15,
                    leftPadding: 15,
                    rightPadding: 15,

                  )
                ],
              ),
            ),
            Positioned(
              right: TSizes.xl,
              top: THelperFunctions.screenHeight() / 1.45,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.blue[100],
                onPressed: () {},
                label: const Icon(
                  Icons.call,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
