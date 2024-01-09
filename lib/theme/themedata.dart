// import 'package:flutter/material.dart';

// class MyThemes {
//   static Color gradientColorA = const Color(0xFFFFFFFF);
//   static Color gradientColorB = const Color(0xFF000000);

//   ThemeData getTheme(String themeName) {
//     if (themeName == 'darkTheme') {
//       gradientColorA = const Color(0xFFFFFFFF);
//       gradientColorB = const Color(0xFF000000);
//       return _darkTheme;
//     } else if (themeName == 'lightTheme') {
//       gradientColorA = const Color(0xFF000000);
//       gradientColorB = const Color(0xFFFFFFFF);
//       return _lightTheme;
//     } else {
//       return _lightTheme;
//     }
//   }

//   final _darkTheme = ThemeData(
//     primarySwatch: Colors.grey,
//     primaryColor: Colors.black,
//     brightness: Brightness.dark,
//     floatingActionButtonTheme:
//         const FloatingActionButtonThemeData(foregroundColor: Colors.black),
//     dividerColor: Colors.black12,
//   );

//   final _lightTheme = ThemeData(
//     brightness: Brightness.light,
//     dividerColor: Colors.white54,
//     disabledColor: Colors.grey,
//     floatingActionButtonTheme:
//         const FloatingActionButtonThemeData(foregroundColor: Colors.white),
//     primaryColor: Colors.white,
//     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
//         .copyWith(background: Colors.black),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider({required this.isLightTheme});

  getCurrentStatusNavigatonBarColors() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  toggleThemeData() {}

  ThemeData themeData() {
    return ThemeData(
        brightness: isLightTheme ? Brightness.light : Brightness.dark,
        scaffoldBackgroundColor: isLightTheme ? Colors.yellow : Colors.black,
        textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isLightTheme ? Colors.red : Colors.white)));
  }

  ThemeMode themeMode() {
    return ThemeMode(
      gradientColors: isLightTheme
          ? [
              const Color(0xffF7E3D7),
              const Color(0xffFFA877),
              const Color(0xffFBBA95),
              const Color(0xffEF6518),
            ]
          : [Colors.black, Colors.black],
      colorA: isLightTheme ? Colors.black : Colors.orange,
      colorB: isLightTheme ? Colors.orange : Colors.black,
      colorC: isLightTheme
          ? Colors.black.withOpacity(.1)
          : Colors.grey.withOpacity(.3),
    );
  }
}

class ThemeMode {
  List<Color>? gradientColors;
  Color? colorA;
  Color? colorB;
  Color? colorC;
  // Color? colorD;

  ThemeMode({
    this.gradientColors,
    this.colorA,
    this.colorB,
    this.colorC,
    // this.colorD
  });
}
