import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class Constants {
  static String appName = "E-Restaurant";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color darkAccent = const Color.fromARGB(255, 240, 83, 80);
  static Color lightBG = const Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = const Color.fromARGB(255, 249, 213, 51);

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      onSecondary: lightAccent,
    ),
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    hintColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: lightAccent,
      ),
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).headline6,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    // cursorColor: darkAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.white24),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    ),
    // textTheme: TextTheme(
    //   titleLarge: TextStyle(
    //     color: lightBG,
    //     fontSize: 18.0,
    //     fontWeight: FontWeight.w800,
    //   ),
    // ),
    iconTheme: IconThemeData(
      color: darkAccent,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: darkAccent,
      background: darkBG,
      brightness: Brightness.dark,
      error: Colors.red,
      primary: darkPrimary,
      onBackground: darkBG,
      onError: Colors.red,
      onPrimary: darkPrimary,
      onSecondary: darkAccent,
      onSurface: darkBG,
      surface: darkBG,
    ),
  );

  static void toast(String message, ToastType toastType,
      {bool isLong = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: isLong ? Toast.LENGTH_SHORT : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            toastType == ToastType.error ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static List<DropdownMenuItem<String>> gender = [
    const DropdownMenuItem(value: "Male", child: Text("Male")),
    const DropdownMenuItem(value: "Female", child: Text("Female"))
  ];

  static Shimmer foodShimmer(context) => Shimmer(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.grey[900]!,
              Colors.grey[900]!,
              Colors.grey[800]!,
              Colors.grey[900]!,
              Colors.grey[900]!
            ],
            stops: const <double>[
              0.0,
              0.35,
              0.5,
              0.65,
              1.0
            ]),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 1.25),
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.red,
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            );
          },
        ),
      );
  static Shimmer carsolShimmer(double h) => Shimmer(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.grey[900]!,
              Colors.grey[900]!,
              Colors.grey[800]!,
              Colors.grey[900]!,
              Colors.grey[900]!
            ],
            stops: const <double>[
              0.0,
              0.35,
              0.5,
              0.65,
              1.0
            ]),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            // childAspectRatio: MediaQuery.of(context).size.width /
            //     (MediaQuery.of(context).size.height / 1.25),
          ),
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 110,
                  height: h * .8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red,
                  ),
                  margin: const EdgeInsets.fromLTRB(4, 6, 4, 5),
                ),
                Container(
                  height: 14,
                  width: 120,
                  margin: const EdgeInsets.fromLTRB(4, 6, 4, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 10,
                  width: 100,
                  margin: const EdgeInsets.fromLTRB(4, 6, 4, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red,
                  ),
                ),
              ],
            );
          },
        ),
      );
}

enum ToastType { success, error }

enum RequestState { idle, loading, loaded, error }

class FirebaseConst {
  // firebase_consts
  static String foods = "foods";
  static String users = "users";
  static String reviews = "reviews";
  static String orders = "orders";
}
