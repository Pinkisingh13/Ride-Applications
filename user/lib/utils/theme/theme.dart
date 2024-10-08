
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    scaffoldBackgroundColor: TColors.light,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
}
//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: 'Poppins',
//     disabledColor: TColors.grey,
//     brightness: Brightness.dark,
//     primaryColor: TColors.primary,
//     textTheme: TTextTheme.darkTextTheme,
//     chipTheme: TChipTheme.darkChipTheme,
//     scaffoldBackgroundColor: TColors.black,
//     appBarTheme: TAppBarTheme.darkAppBarTheme,
//     bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
//     elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
//     outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
//     inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
//   );
// }
