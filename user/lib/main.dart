import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user/bindings/general_bindings.dart';
import 'package:user/features/auth/view/splash/splash.dart';
import 'package:user/utils/constants/text_strings.dart';
import 'utils/theme/theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
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
