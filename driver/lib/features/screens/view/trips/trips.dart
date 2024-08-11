import 'package:carousel_slider/carousel_slider.dart';
import 'package:driver/features/screens/controller/home_controller/home_controller.dart';
import 'package:driver/features/screens/controller/trip_controller/trip_controller.dart';
import 'package:driver/features/screens/view/trips/widgets/pickup_dropoff.dart';
import 'package:driver/features/screens/view/trips/widgets/ride_details.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:driver/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import 'widgets/accept_reject_buttons.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());

    return Scaffold(
      appBar: const PAppBar(
        title: 'Select Trip',
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                if (controller.rides.isEmpty) {
                  return Center(
                    child: Text(
                        "There is No Ride Available. Please check after sometime"),
                  );
                }
                return CarouselSlider.builder(
                  itemCount: controller.rides.length,
                  itemBuilder: (context, index, realIndex) {
                    final details = controller.rides[index];
                    return Container(
                      margin: const EdgeInsets.all(3),
                      padding: const EdgeInsets.only(
                          top: TSizes.defaultSpace,
                          left: TSizes.sm,
                          right: TSizes.sm),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.blue[50]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pick up
                          PickUpAndDropOff(
                            title: "Pick up",
                            address: details.origin,
                            image: "assets/images/pickup.png",
                            isShowImage: true,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          /// Drop off
                          PickUpAndDropOff(
                            title: "Drop off",
                            address: details.destination,
                            image: "assets/images/drop_off.png",
                            isShowImage: true,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),

                          // Divider
                          const Divider(),

                          ///  RIDE DETAILS Container
                          RideDetailsContainer(
                            rides: details,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: TSizes.spaceBtwSections * 1.20,
                          ),

                          /// ACCEPT AND REJECT Buttons
                          AcceptAndRejectButtons(
                            onTapAccept: () {
                              final controller2 =
                                  Get.put(TripAcceptController());
                              controller2.acceptingRides(details.uid, details);
                              controller.rides.remove(controller.rides[index]);
                            },
                            onTapReject: () {
                              controller.rides.remove(controller.rides[index]);
                            },
                          ),
                        ],
                      ),
                    );
                  },

                  /// CAROUSEL OPTIONS
                  options: CarouselOptions(
                    height: THelperFunctions.screenHeight() / 1.20,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    enableInfiniteScroll: false,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
