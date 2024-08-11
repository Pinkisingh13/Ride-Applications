import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: const Image(
              height: TSizes.iconMd,
              width: TSizes.iconMd,
              image: AssetImage(
                "assets/logos/google-icon.png",
              ),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: const Image(
              height: TSizes.iconMd,
              width: TSizes.iconMd,
              image: AssetImage(
                "assets/logos/facebook-icon.png",
              ),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
      ],
    );
  }
}
