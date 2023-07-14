// import 'package:flutter/material.dart';
// import 'package:kochure/theme/app_textstyles.dart';

// import 'app_fontweight.dart';
// import 'brand_theme_color.dart';

// //TODO: NOT EDITED THE DARK MODE YET
// TextTheme darkTextTheme(TextTheme base) {
//   return base.copyWith(
//       // the display in showDatePicker
//       // displayMedium: ,

//       //default text in app
//       bodyMedium: AppTextStyle.bodyTextTextstyle.copyWith(
//         color: BrandThemeColorDark.buttonTextDark,
//       ),
//       bodyLarge: AppTextStyle.bodyTextTextstyle.copyWith(
//         color: TagoLight.textFieldHintsLight,
//       ),
//       // the text in buttons
//       labelLarge: AppTextStyle.buttonTextTextstyle.copyWith(
//         color: TagoLight.buttonTextLight,
//       ),
//       //for errors in textfield
//       labelSmall: AppTextStyle.errorTextTextstyle.copyWith(
//         color: BrandThemeColorDark.errorColorDark,
//       ),
//       // the text in Appbar and dialogs
//       titleLarge: AppTextStyle.appBarTextStyle.copyWith(
//         color: BrandThemeColorDark.appBarTitleDark,
//       ),

//       // the Title text in  ListTiles widget
//       titleMedium: AppTextStyle.titleInCardTextstyle.copyWith(
//         color: BrandThemeColorDark.appBarTitleDark,
//       ),

// //for little instructions close to textbuttons
//       titleSmall: AppTextStyle.textFieldHintsStyle.copyWith(
//         color: TagoLight.textFieldHintsLight,
//       )

//       // the text in [month, year] of showDatePicker
//       // headlineSmall:

//       //

//       );
// }

// //! LIGHT texttheme MODE
// TextTheme _lightTextTheme(TextTheme base) {
//   return base.copyWith(
//       // the display in showDatePicker
//       // displayMedium: ,

//       //default text in app
//       bodyMedium: AppTextStyle.bodyTextTextstyle.copyWith(
//         color: TagoLight.buttonTextLight,
//       ),
//       bodyLarge: AppTextStyle.bodyTextTextstyle.copyWith(
//         color: TagoLight.textFieldHintsLight,
//       ),
//       // the text in buttons
//       labelLarge: AppTextStyle.buttonTextTextstyle.copyWith(
//         color: TagoLight.buttonTextLight,
//       ),
//       //for errors in textfield
//       labelSmall: AppTextStyle.errorTextTextstyle.copyWith(
//         color: TagoLight.errorColorLight,
//       ),
//       // the text in Appbar and dialogs
//       titleLarge: AppTextStyle.appBarTextStyle.copyWith(
//         color: TagoLight.appBarTitleLight,
//       ),

//       // the Title text in  ListTiles widget
//       titleMedium: AppTextStyle.titleInCardTextstyle.copyWith(
//         color: TagoLight.appBarTitleLight,
//       ),

//       //for little instructions close to textbuttons
//       titleSmall: AppTextStyle.textFieldHintsStyle.copyWith(
//         color: TagoLight.textFieldHintsLight,
//       )

//       // the text in [month, year] of showDatePicker
//       // headlineSmall:

//       //
//       );
// }

// class MyThemeMode {
//   //! DARK THEME
//   static final darkTheme = ThemeData(
//     scaffoldBackgroundColor: BrandThemeColorDark.scaffoldBackgroundDarkColor,
//     primaryColor: BrandThemeColorDark.primaryColorDark,
//     cardColor: BrandThemeColorDark.cardColorDark,
//     //   appBarTheme: AppBarTheme(
//     //     backgroundColor: BrandColors.colorPrimaryDark,
//     //     titleTextStyle: AppTextStyle().appBarTextStyleDark,
//     //     shadowColor: BrandColors.colorButtonTextLight.withOpacity(0.4),
//     //     shape: const UnderlineInputBorder(
//     //       borderSide: BorderSide(
//     //         width: 3,
//     //         color: BrandColors.colorGreen,
//     //         // strokeAlign: StrokeAlign.inside,
//     //       ),
//     //     ),
//     //   ),
//     //   // errorColor: BrandColors.colorPurple,
//     inputDecorationTheme: InputDecorationTheme(
//       hintStyle: AppTextStyle.textFieldHintsStyle.copyWith(
//         color: BrandThemeColorDark.textFieldHintsDark,
//       ),
//       counterStyle: AppTextStyle.textFieldHintsStyle.copyWith(
//         color: BrandThemeColorDark.textFieldHintsDark,
//         fontSize: 12,
//       ),
//       contentPadding: const EdgeInsets.all(20),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: const BorderSide(
//           width: 0,
//           style: BorderStyle.none,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(20.0),
//         borderSide: const BorderSide(
//             width: 0.4, color: BrandThemeColorDark.textFieldHintsDark),
//       ),
//       fillColor: BrandThemeColorDark.textFieldFilledDark,
//       filled: true,
//     ),
//     //   primaryColor: BrandColors.colorGreen,
//     //   listTileTheme: const ListTileThemeData(
//     //     iconColor: BrandColors.colorBackground,
//     //     textColor: BrandColors.colorBackground,
//     //   ),
//     //   // cardColor: BrandColors.colorPrimary,
//     //   cardTheme: CardTheme(
//     //     elevation: 2,
//     //     color: BrandColors.colorPrimaryDark.withOpacity(0.8),
//     //     shape: OutlineInputBorder(
//     //       borderRadius: BorderRadius.circular(10),
//     //       borderSide: BorderSide(
//     //         color: BrandColors.colorGreen.withOpacity(0.3),
//     //       ),
//     //     ),
//     //   ),
//     //   dialogTheme: DialogTheme(
//     //     backgroundColor: BrandColors.colorPrimaryDark,
//     //     titleTextStyle: AppTextStyle().dialogTitleStyleDark,
//     //     contentTextStyle: AppTextStyle().dialogContentStyleDark,
//     //     shape: RoundedRectangleBorder(
//     //         borderRadius: BorderRadius.circular(15),
//     //         side:
//     //             BorderSide(color: BrandColors.colorPrimaryDark.withOpacity(0.5))),
//     //   ),
//     //   primaryIconTheme: const IconThemeData(
//     //     color: BrandColors.colorBackground,
//     //   ),
//     //   iconTheme: const IconThemeData(
//     //     color: BrandColors.colorBackground,
//     //   ),
//     //   drawerTheme: const DrawerThemeData(
//     //     backgroundColor: BrandColors.colorPrimary,
//     //   ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: BrandThemeColorDark.buttonBGDark,
//         // textStyle: AppTextStyle.textButtonStyle,
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: BrandThemeColorDark.buttonBGDark,
//         fixedSize: const Size(double.maxFinite, 55),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//       ),
//     ),
//     //   dividerColor: BrandColors.colorGreen,
//     //   tabBarTheme: TabBarTheme(
//     //     unselectedLabelColor: BrandColors.colorUnselectedOptions,
//     //     unselectedLabelStyle: AppTextStyle().navBarTextStyle,
//     //     labelStyle: AppTextStyle().navBarTextStyle,
//     //     labelColor: BrandColors.colorPrimary,
//     //     indicatorSize: TabBarIndicatorSize.label,
//     //     labelPadding: const EdgeInsets.all(5),
//     //     indicator: const UnderlineTabIndicator(
//     //         borderSide: BorderSide(
//     //           color: BrandColors.colorPrimary,
//     //           width: 3,
//     //           style: BorderStyle.solid,
//     //         ),
//     //         insets: EdgeInsets.all(5)),
//     //   ),
//     //   // bottomAppBarColor:
//     //   bottomAppBarTheme: const BottomAppBarTheme(
//     //     shape: CircularNotchedRectangle(),
//     //     color: BrandColors.colorPrimaryDark,
//     //   ),
//     //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     //     backgroundColor: BrandColors.colorPrimaryDark,
//     //     elevation: 5,
//     //     selectedItemColor: BrandColors.colorGreen,
//     //     unselectedItemColor: BrandColors.colorUnselectedOptions,
//     //     selectedLabelStyle: AppTextStyle().navBarTextStyle,
//     //     unselectedLabelStyle: AppTextStyle().navBarTextStyle,
//     //   ),
//     //   highlightColor: BrandColors.colorButtonTextLight,
//     //   // canvasColor: ColorConstant.shapeColorDarkBg,
//     textTheme: darkTextTheme(ThemeData.dark(useMaterial3: true).textTheme),
//     textSelectionTheme: const TextSelectionThemeData(
//       selectionColor: Color(0xff58A4EB),
//       selectionHandleColor: Color(0xff58A4EB),
//       cursorColor: Color(0xff58A4EB),
//     ),
//   );

//! LIGHT THEME

import '../app.dart';
import 'app_fontweight.dart';
import 'brand_theme_color.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: TagoLight.scaffoldBackgroundColor,
  primaryColor: TagoLight.primaryColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: TagoLight.scaffoldBackgroundColor,
    // titleTextStyle: AppTextStyle().appBarTextStyleLight,
    shape: InputBorder.none,
  ),
  // cardColor: TagoLight.cardColorLight,
  // inputDecorationTheme: InputDecorationTheme(
  //   hintStyle: AppTextStyle.textFieldHintsStyle.copyWith(
  //     color: TagoLight.textFieldHintsLight,
  //   ),
  //   counterStyle: AppTextStyle.textFieldHintsStyle.copyWith(
  //     color: TagoLight.textFieldHintsLight,
  //     fontSize: 12,
  //   ),
  //   contentPadding: const EdgeInsets.all(20),
  //   border: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(20.0),
  //     borderSide: const BorderSide(
  //       width: 0,
  //       style: BorderStyle.none,
  //     ),
  //   ),
  //   focusedBorder: OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(20.0),
  //     borderSide: const BorderSide(
  //         width: 0.4, color: TagoLight.textFieldHintsLight),
  //   ),
  //   fillColor: TagoLight.textFieldFilledLight,
  //   filled: true,
  // ),

// //TODO: EDIT DIALOG LATER
  // dialogTheme: DialogTheme(
  //   backgroundColor: BrandColors.colorBackground,
  //   titleTextStyle: AppTextStyle().dialogTitleStyleLight,
  //   contentTextStyle: AppTextStyle().dialogContentStyleLight,
  //   shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(15),
  //       side: BorderSide(color: BrandColors.colorPrimary.withOpacity(0.5))),
  // ),
  // //

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontWeight: AppFontWeight.w600,
          fontSize: 12,
        ),
        foregroundColor: TagoDark.primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: TagoLight.primaryColor,
      fixedSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),

//     // tabBarTheme: TabBarTheme(
//     //   unselectedLabelColor: BrandColors.colorUnselectedOptions,
//     //   unselectedLabelStyle: AppTextStyle().navBarTextStyle,
//     //   labelStyle: AppTextStyle().navBarTextStyle,
//     //   labelColor: BrandColors.colorPrimary,
//     //   indicatorSize: TabBarIndicatorSize.label,
//     //   indicator: const UnderlineTabIndicator(
//     //       borderSide: BorderSide(
//     //         color: BrandColors.colorPrimary,
//     //         width: 3,
//     //         style: BorderStyle.solid,
//     //       ),
//     //       insets: EdgeInsets.all(5)),
//     // ),
//     // bottomAppBarColor:

//     // bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     //   backgroundColor: BrandColors.colorBackgroundPink,
//     //   elevation: 5,
//     //   selectedItemColor: BrandColors.colorPrimaryDark,
//     //   unselectedItemColor: BrandColors.colorUnselectedOptions,
//     //   selectedLabelStyle: AppTextStyle().navBarTextStyle,
//     //   unselectedLabelStyle: AppTextStyle().navBarTextStyle,
//     // ),
//     //TODO: EDIT THE LISTILE LATER
//     // listTileTheme: const ListTileThemeData(
//     //     iconColor: BrandColors.colorButtonText,
//     //     textColor: BrandColors.colorButtonText),
//     // iconTheme: const IconThemeData(
//     //   color: BrandColors.colorButtonText,
//     //   opacity: 0.9,
//     // ),
//     // canvasColor: ColorConstant.shapeColorLightBg,
//     textTheme: _lightTextTheme(ThemeData.light(useMaterial3: true).textTheme),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0xff58A4EB),
    selectionHandleColor: Color(0xff58A4EB),
    cursorColor: Color(0xff58A4EB),
  ),
  // colorScheme:
  //     const ColorScheme.light().copyWith(secondary: const Color(0xff858585)),
);



