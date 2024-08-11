import 'package:flutter/material.dart';
import 'package:driver/utils/constants/colors.dart';
import 'package:driver/utils/constants/sizes.dart';

class PickUpAndDropOff extends StatelessWidget {
  const PickUpAndDropOff({
    super.key,
    required this.title,
    required this.address,
    this.titleTextStyle,
    this.textStyle2 = const TextStyle(),
    this.image = "",
    this.isShowImage = true,
    this.alignment,
  });

  final String title, address;
  final String image;
  final bool isShowImage;
  final TextStyle? titleTextStyle, textStyle2;
  final CrossAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment  ?? CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isShowImage && image.isNotEmpty)
              Image(
                image: AssetImage(image),
                height: 20,
              ),
            if (isShowImage && image.isNotEmpty)
              const SizedBox(
                width: TSizes.sm,
              ),
            Text(
              title,
              style: titleTextStyle ??
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: TColors.darkGrey),
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(
          address,
          style: textStyle2,
        ),
      ],
    );
  }
}

