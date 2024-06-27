import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    surfaceTint: Colors.transparent,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'Changa-Regular',
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.amber.withOpacity(0.5),
    cursorColor: Colors.amber,
    selectionHandleColor: Colors.amber,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.red,
  ),
  expansionTileTheme: ExpansionTileThemeData(
    iconColor: Colors.amber,
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.amber,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.normal,
      fontFamily: 'Changa-Regular',
    ),
    border: InputBorder.none,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      fontFamily: 'Changa-Regular',
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontFamily: 'Changa-Regular',
    ),
    labelSmall: TextStyle(
      //content info
      color: Colors.white60,
      fontSize: 13,
      fontFamily: 'Changa-Regular',
    ),
    bodySmall: TextStyle(
      //note body display
      color: Colors.white60,
      overflow: TextOverflow.fade,
      fontSize: 14,
      fontFamily: 'Changa-Regular',
    ),
    bodyMedium: TextStyle(
      //note body display
      color: Colors.white,
      overflow: TextOverflow.fade,
      fontSize: 16,
      fontFamily: 'Changa-Regular',
    ),
  ),
  dividerColor: Colors.transparent,
  popupMenuTheme: PopupMenuThemeData(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Changa-Regular',
    ),
    color: Colors.grey,
  ),
  primaryColor: Colors.grey.shade900,
);

//------------------------------------------------------------

final ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  colorScheme: ColorScheme.light(
    background: Color.fromRGBO(244, 244, 244, 1),
    surfaceTint: Colors.transparent,
    primary: Colors.grey, // <-- SEE HERE
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.grey.shade400,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.amber, // button text color
    ),
  ),
  datePickerTheme: DatePickerThemeData(
    headerBackgroundColor: Colors.grey,
    dayStyle: TextStyle(
      color: Colors.red,
    ),
    backgroundColor: Color.fromRGBO(244, 244, 244, 1),
  ),
  splashColor: Colors.amber.withOpacity(0.5),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: 'Changa-Regular',
      fontWeight: FontWeight.bold,
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.normal,
      fontFamily: 'Changa-Regular',
    ),
    border: InputBorder.none,
  ),
  expansionTileTheme: ExpansionTileThemeData(
    iconColor: Colors.black,
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'Changa-Regular',
      fontSize: 20,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Changa-Regular',
    ),
    titleSmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Changa-Regular',
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      //content info
      color: Colors.black54,
      fontFamily: 'Changa-Regular',

      fontSize: 13,
    ),
    bodySmall: TextStyle(
      //note body display
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Changa-Regular',

      overflow: TextOverflow.fade,
    ),
    bodyMedium: TextStyle(
      //note body display
      color: Colors.black54,
      fontFamily: 'Changa-Regular',

      overflow: TextOverflow.fade,
      fontSize: 16,
    ),
  ),
  dividerColor: Colors.transparent,
  popupMenuTheme: PopupMenuThemeData(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontFamily: 'Changa-Regular',
    ),
    color: Colors.white,
  ),
  primaryColor: Color.fromRGBO(223, 223, 223, 1),
);

ThemeData currTheme(BuildContext context) {
  return Theme.of(context);
}
