import 'package:driver/features/auth/controller/signup/signup_controller.dart';
import 'package:driver/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // FullName
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                TValidator.validateEmptyText('username', value),
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // Email
          TextFormField(
            validator: (value) => TValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          //Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.togglePassword.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.togglePassword.value =
                      !controller.togglePassword.value,
                  icon: Icon(
                    controller.togglePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

          // Vehicle Number
          TextFormField(
            validator: (value) =>
                TValidator.validateEmptyText("Vehicle Number", value),
            controller: controller.vehicleNumber,
            decoration: const InputDecoration(
              labelText: "Vehicle Number",
              helperText: "Ex: AS96GHKJK",

              prefixIcon: Icon(Iconsax.car),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Vehicle type
          TextFormField(
            validator: (value) =>
                TValidator.validateEmptyText("Vehicle Type", value),
            controller: controller.vehicleType,
            decoration: const InputDecoration(
              labelText: "Vehicle Type",
              helperText: "Ex: Car, Bike",
              prefixIcon: Icon(Iconsax.car),
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          // Sign up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
