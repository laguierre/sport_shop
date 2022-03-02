import 'package:flutter/material.dart';

import '../data/constants.dart';

/*final myTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light()
        .textTheme
        .copyWith(caption: TextStyle(fontFamily: 'Roboto')),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red));
*/
final myTheme = ThemeData(
// Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,

  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 35.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: kPrimaryColor),
    headline6: TextStyle(fontSize: 28.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: kPrimaryColor),
    headline5: TextStyle(fontSize: 26.0, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black54),
    headline4: TextStyle(fontSize: 18.0, fontFamily: 'Roboto', fontWeight: FontWeight.w400, color: Colors.black54),
    bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: kPrimaryColor),
  ),
);