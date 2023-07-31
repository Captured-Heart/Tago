//! LIGHT THEME

import '../app.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: TagoLight.scaffoldBackgroundColor,
  primaryColor: TagoLight.primaryColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: TagoLight.scaffoldBackgroundColor,
    foregroundColor: TagoDark.textBold,
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
        fontWeight: AppFontWeight.w700,
        fontSize: 14,
        fontFamily: TextConstant.fontFamilyNormal,
      ),
      foregroundColor: TagoDark.primaryColor,
    ),
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
  // listTileTheme: const ListTileThemeData(

  // ),
  // iconTheme: const IconThemeData(
  //   color: BrandColors.colorButtonText,
  //   opacity: 0.9,
  // ),
//     // canvasColor: ColorConstant.shapeColorLightBg,x
  textTheme: _lightTextTheme(ThemeData.light(useMaterial3: true).textTheme),
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: Color(0xff58A4EB),
    selectionHandleColor: Color(0xff58A4EB),
    cursorColor: Color(0xff58A4EB),
  ),
  // colorScheme:
  //     const ColorScheme.light().copyWith(secondary: const Color(0xff858585)),
);

// light theme for text
TextTheme _lightTextTheme(TextTheme base) {
  return base.copyWith(
    // the display in showDatePicker
    // displayMedium: ,

    //default text in app
    bodyMedium: AppTextStyle.normalBodyText.copyWith(
        color: TagoLight.textLight, fontFamily: TextConstant.fontFamilyLight),

//normal titles in body text
    bodyLarge: AppTextStyle.normalBodyTitle.copyWith(
      fontFamily: TextConstant.fontFamilyNormal,
      color: TagoLight.textLight,
    ),

    // the text in buttons
    labelLarge: AppTextStyle.buttonTextTextstyleLight.copyWith(
        color: TagoDark.scaffoldBackgroundColor,
        fontFamily: TextConstant.fontFamilyNormal),
    //for errors in textfield
    labelSmall: AppTextStyle.errorTextTextstyle.copyWith(
      color: TagoLight.textError,
    ),
    //
    labelMedium: AppTextStyle.normalBodyTitle.copyWith(
      color: TagoDark.textBold,
      fontWeight: FontWeight.w500,
      fontFamily: TextConstant.fontFamilyNormal,
    ),
    // the text in Appbar and dialogs
    titleLarge: AppTextStyle.appBarTextStyleLight.copyWith(
      color: TagoLight.textBold,
    ),

    // the Title text in  ListTiles widget
    titleMedium: AppTextStyle.listTileTitleLight.copyWith(
      color: TagoLight.textBold,
      fontFamily: TextConstant.fontFamilyNormal,
    ),
    titleSmall: AppTextStyle.listTileTitleLight.copyWith(
      color: TagoLight.textBold,
      fontFamily: TextConstant.fontFamilyNormal,
      fontSize: 12,
    ),
    // the text in [month, year] of showDatePicker
    // headlineSmall:

    //
  );
}
