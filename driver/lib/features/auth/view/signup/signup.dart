import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.light,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: TColors.secondary,
            systemNavigationBarColor: TColors.secondary,
            systemNavigationBarDividerColor: TColors.primary,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 1.37,
                ),

                /// Form
                const TSignupForm(),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
