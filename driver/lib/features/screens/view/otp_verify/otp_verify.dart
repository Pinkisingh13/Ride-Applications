import 'package:driver/common/styles/spacing_style.dart';
import 'package:driver/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../controller/otp_verify/otp_verify_controller.dart';
import '../../model/pending_ride_model/pending_ride_model.dart';

class OtpVerifyScreen extends StatelessWidget {
  const OtpVerifyScreen({super.key, required this.id,required this.rides});
  final String id;
  final Ride rides;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpVerificationController());
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: const PAppBar(title: "Verify OTP"),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: controller.pinPutFormKey,
                  child: Column(
                    children: [
                      Text(
                        "Ride will be started only otp will succefully verified. Please make sure to enter correct digits in otp fields.",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.grey[400],
                            ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections * 3,
                      ),
                      Pinput(
                        controller: controller.pinController,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        validator: (value) {
                          if (value == null || value.length < 4) {
                            return 'Pin is incorrect';
                          }
                          return null;
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections * 4,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromWidth(140),
                            backgroundColor: Colors.green[200],
                            padding: const EdgeInsets.only(
                                top: TSizes.md, bottom: TSizes.md)),
                        onPressed: () {
                          controller.verifyOtp(id, rides);
                        },
                        child: Text(
                          "Submit",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 15),
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
