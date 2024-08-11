import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user/common/widgets/appbar/appbar.dart';
import 'package:user/features/screens/controller/location_selector/location_controller.dart';
import 'package:user/features/screens/view/location_selector/widgets/location_auto_listtile.dart';
import 'package:user/utils/constants/sizes.dart';
import 'package:user/utils/helpers/helper_functions.dart';
import 'package:user/utils/validators/validation.dart';

import '../../../../utils/constants/colors.dart';

// old api key:
// AIzaSyDKWcBeLXqroFcQak9RDdVsWmro8kkPKNQ

// New key
// AIzaSyAB54-3VD4rxu_qATXOBIlyjJnWZiiG95E

class LocationSelectorScreen extends StatelessWidget {
  const LocationSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationSelectorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const PAppBar(title: "Select your location"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                Form(
                  key: controller.locationFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pick up location
                      SizedBox(
                        width: THelperFunctions.screenWidth() / 1.50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Image(
                                  image: AssetImage("assets/images/pickup.png"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: TSizes.sm,
                                ),
                                Text(
                                  "Pick up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: TColors.darkGrey),
                                ),
                              ],
                            ),

                            const SizedBox(height: TSizes.md),

                            // Pick up Location
                            TextFormField(
                              controller: controller.pickupLocation,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, "Pick up Location"),
                              onChanged: (value) {
                                controller.setActiveField('pickup');
                                controller.placeLocation(value);
                              },
                              decoration: InputDecoration(
                                labelText: "Enter your pickup location",
                                labelStyle: const TextStyle().copyWith(
                                  fontSize: TSizes.fontSizeSm,
                                  color:
                                      const Color.fromARGB(255, 212, 212, 212),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      // Drop off location
                      SizedBox(
                        width: THelperFunctions.screenWidth() / 1.50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Image(
                                  image:
                                      AssetImage("assets/images/drop_off.png"),
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: TSizes.sm,
                                ),
                                Text(
                                  "Drop off",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: TColors.darkGrey),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.md),
                            TextFormField(
                              onChanged: (value) {
                                controller.setActiveField('dropoff');
                                controller.placeLocation(value);
                              },
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, "Drop off Location"),
                              controller: controller.dropOffLocation,
                              decoration: InputDecoration(
                                labelText: "Enter your drop off location",
                                labelStyle: const TextStyle().copyWith(
                                  fontSize: TSizes.fontSizeSm,
                                  color:
                                      const Color.fromARGB(255, 212, 212, 212),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      Obx(
                        () => SizedBox(
                          height: 250,
                          child: ListView.builder(
                            itemCount: controller.locationDetails.length,
                            itemBuilder: (context, index) {
                              final location =
                                  controller.locationDetails[index];
                              return LocationAutoListtile(
                                  onTap: () {
                                  controller.selectLocationFromList(location.description);
                                  },
                                  location: location.description);
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwSections),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                const Size(TSizes.buttonWidth * 1.30, 0),
                          ),
                          onPressed: () {
                            controller.selectLocation();
                          },
                          child: const Text('Calculate'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
