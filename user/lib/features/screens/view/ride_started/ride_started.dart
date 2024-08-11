import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/common/widgets/appbar/appbar.dart';
import 'package:user/features/screens/controller/ride_started/ride_started_controller.dart';
import 'package:user/features/screens/view/waiting_for_driver/waiting_for_driver.dart';

class RideStartedScreen extends StatelessWidget {
  const RideStartedScreen({
    super.key,
    required this.id,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.amount,
    required this.otp,
  });

  final String id;
  final String pickupLocation;
  final String dropoffLocation;
  final String amount,
   otp;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RideStartedController());

    Timer.periodic(const Duration(seconds: 4), (timer) {
      controller.startFetchingRideCompleted(
          id, pickupLocation, dropoffLocation, amount);
      timer.cancel();
    });
    return Scaffold(
      appBar: const PAppBar(title: ""),
      body: ReusableUserWaitingScreen(
        text: "Enjoy Your Ride",
        amount: amount,
        dropOffLocation: dropoffLocation,
        pickupLocation: pickupLocation,
        otp: otp,
      ),
      bottomNavigationBar: BottomNavigationContainer(
        isShowMiddleButton: true,
        amount: amount,
        dropOffLocation: dropoffLocation,
        pickupLocation: pickupLocation,
        otp: otp,
      ),
    );
  }
}
