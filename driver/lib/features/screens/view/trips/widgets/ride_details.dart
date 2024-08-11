import 'package:driver/features/screens/model/pending_ride_model/pending_ride_model.dart';
import 'package:driver/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class RideDetailsContainer extends StatelessWidget {
  const RideDetailsContainer({
    super.key,
    this.isShowName = false,
    required this.rides,
  });

  final Ride rides;

  final bool isShowName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: THelperFunctions.screenWidth(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isShowName
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Fullname",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: TColors.darkGrey),
                    ),
                    Text(
                      "Kritika koria",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TColors.darkGrey),
              ),
              Text(
                "\u{20B9} ${rides.amount}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Distance",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TColors.darkGrey),
              ),
              Text(
               rides.distance,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pick up Time",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: TColors.darkGrey),
              ),
              Text(
                rides.time,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
