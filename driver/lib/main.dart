import 'package:driver/bindings/general_bindings.dart';
import 'package:driver/features/auth/view/splash/splash.dart';
import 'package:driver/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await GetStorage.init();     
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
