import 'package:flutter/material.dart';
import 'package:offersapp/pages/LoginPage.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        color: Colors.lightBlueAccent.withOpacity(0.2),
        child: Column(
          children: [
            SizedBox(
              height: 240,
            ),
            Center(
              child: Image.asset(
                "assets/images/turbopaisa_logo_two.png",
                fit: BoxFit.cover,
                //width: 300,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/coin.png",
                    // width: 80,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(""),
                SizedBox(
                  width: 1,
                ),
                Image.asset(
                  "assets/images/coin_two.png",
                  //width: 80,
                ),
              ],
            ),
            Image.asset(
              "assets/images/splash_screen_image.png",
              fit: BoxFit.cover,
              width: 240,
            ),
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
