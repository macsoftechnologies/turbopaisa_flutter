import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/pages/LoginPage.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(gradient: AppColors.splashAppGradientBg),
        child: Stack(
          children: [
            // SizedBox(
            //   height: 239.h,
            // ),
            Positioned(
              top: 239.h,
              left: 128.w,
              right: 128.w,
              child: Image.asset(
                "assets/images/turbopaisa_logo_two.png",
                // fit: BoxFit.cover,
                height: 156.h,
              ),
            ),
            Positioned(
              top: 538.h,
              left: 58.w,
              child: Image.asset(
                "assets/images/coin.png",
                // width: 80,
              ),
            ),

            Positioned(
              top: 560.h,
              right: 58.w,
              child: Image.asset(
                "assets/images/coin.png",
                // width: 80,
              ),
            ),
            Positioned(
              bottom: 37.h,
              left: 94.w,
              right: 94.w,
              child: Image.asset(
                "assets/images/splash_screen_image.png",
                fit: BoxFit.cover,
                height: 177.h,
                // width: 240,
              ),
            ),
            // Spacer(),

            // SizedBox(height: 20,),
          ],
        ),
      )),
    );
  }

  Future<void> navigateToNext() async {
    // user
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 3), () {
      if (prefs.containsKey("user")) {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }
}
