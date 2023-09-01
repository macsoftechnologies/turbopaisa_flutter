import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:offersapp/pages/otp_verification_page.dart';
import 'package:offersapp/pages/registration_new.dart';
import 'package:offersapp/pages/splashscreen_page.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';

Future<void> main() async {
  //#222467
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: primaryColor, // navigation bar color
    statusBarColor: AppColors.primaryDarkColor, // status bar color
  ));
  await ScreenUtil.ensureScreenSize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      //figma reference
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primaryColor1,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            // fontFamily: "Poppins"
            textTheme:
                GoogleFonts.poppinsTextTheme(), //.apply(fontSizeFactor: 1.sp),
            // useMaterial3: true,
          ),
          home: SplashScreenPage(),
          // home: VerificationPage(),
        );
      },
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primaryColor: AppColors.primaryColor1,
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     // fontFamily: "Poppins"
    //     textTheme: GoogleFonts.poppinsTextTheme(),
    //     // useMaterial3: true,
    //   ),
    //   // home: SplashScreenPage(),
    //   home: RegistrationPageNew(),
    // );
  }
}
