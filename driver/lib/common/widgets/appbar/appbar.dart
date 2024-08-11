import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

// AppBar for Home Screen
class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 60,
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Image(
              image: AssetImage("assets/logos/user.png"),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: TColors.light,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

// AppBar for all screens
class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PAppBar({super.key, required this.title, this.actions, this.isBackButton = true});

  final String title;
  final bool isBackButton;
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
      leading: isBackButton ? IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: TColors.white,
          size: 20,
        ),
      ) : const SizedBox(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
