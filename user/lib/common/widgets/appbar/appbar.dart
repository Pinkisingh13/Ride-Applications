import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user/data/authentication/authentication.dart';
import 'package:user/utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

// AppBar for Home Screen
class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // decoration: const BoxDecoration(color: TColors.grey),

        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.pink[50],
                      ),
                      child: const Image(
                        image: AssetImage("assets/images/user2.png"),
                        height: 60,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  const Column(
                    children: [
                      Text("Good Morning,"),
                      Text("Thomas zebanche "),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_sharp,
                color: TColors.darkGrey,
              ),
            ),
            IconButton(
              onPressed: () {
                AuthenticationRepository.instance.logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

// AppBar for all screens
class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColors.blueDarkShade,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: TColors.blueDarkShade,
        systemNavigationBarColor: TColors.blueDarkShade,
        systemNavigationBarDividerColor: TColors.blueDarkShade,
        statusBarIconBrightness: Brightness.light,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: TColors.white),
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: TColors.white,
          size: 20,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
