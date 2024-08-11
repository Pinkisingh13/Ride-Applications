
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: TColors.secondary,
        systemNavigationBarColor: TColors.secondary,
        systemNavigationBarDividerColor: TColors.primary,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(    
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //Title & Sub-Title
                TLoginHeader(),

                /// Form
                TLoginForm(),

                /// Divider
                TFormDivider(dividerText: TTexts.orSignInWith),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                /// Footer
                TSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
