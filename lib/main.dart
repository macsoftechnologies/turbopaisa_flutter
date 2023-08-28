import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offersapp/pages/splashscreen_page.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';

void main() {
  //#222467
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: primaryColor, // navigation bar color
    statusBarColor: AppColors.primaryDarkColor, // status bar color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: AppColors.primaryColor1,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // fontFamily: "Poppins"
          textTheme: GoogleFonts.poppinsTextTheme(),
          // useMaterial3: true,
          ),
      home: SplashScreenPage(),
    );
  }
}
