import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:offersapp/pages/HomePage.dart';
import 'package:offersapp/pages/profile_settings.dart';
import 'package:offersapp/pages/refer_page.dart';
import 'package:offersapp/pages/top_profile.dart';
import 'package:offersapp/pages/tutorial_page.dart';
import 'package:offersapp/pages/wallet_page.dart';
import 'package:offersapp/pages/wheel_widget.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/BottomBarPainter.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:offersapp/utils/constannts.dart';
import 'package:offersapp/widgets/WaveClipper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedPos = 0;

  int selectTab = 0;

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const WalletBalacePage(),
    const ReferPage(),
    const ProfileSettingsPage()
  ];

  Widget getPage(int index) {
    if (index == 0) {
      return HomePage();
    } else if (index == 1) {
      return WalletBalacePage();
    } else if (index == 2) {
      return ReferPage();
    } else if (index == 3) {
      return ProfileSettingsPage();
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    var tabTextStyle = TextStyle(
      fontSize: 9.sp,
      fontWeight: FontWeight.w600,
      height: 1.84,
      color: AppColors.accentColor,
    );
    var circleStrokeColor = Color.fromRGBO(224, 234, 255, 0.8);
    List<TabItem> tabItems = List.of([
      TabItem(Icons.home, "Home", AppColors.accentColor,
          labelStyle: tabTextStyle, circleStrokeColor: circleStrokeColor),
      TabItem(Icons.wallet_rounded, "My Wallet", AppColors.accentColor,
          labelStyle: tabTextStyle, circleStrokeColor: circleStrokeColor),
      TabItem(Icons.share, "Refer & Earn", AppColors.accentColor,
          labelStyle: tabTextStyle, circleStrokeColor: circleStrokeColor),
      TabItem(Icons.person, "My Profile", AppColors.accentColor,
          labelStyle: tabTextStyle, circleStrokeColor: circleStrokeColor),
    ]);

    return Scaffold(
      floatingActionButton: selectTab != 0
          ? null
          : InkWell(
              onTap: () {
                // Navigator.of(context).push(
                //   TutorialOverlay(
                //     child: WheelWidget(),
                //   ),
                // );
                loadSpinWheel();
              },
              child: Image.asset(
                Assets.imagesFabWheel,
                width: 80,
              ),
            ),
      // backgroundColor: AppColors.appGradientBg ,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.appGradientBg),
          child: getPage(selectTab),

          // Column(
          //   children: [
          //
          //     Expanded(
          //       child: IndexedStack(
          //         index: selectTab,
          //         children: _widgetOptions,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CircularBottomNavigation(
          controller: _navigationController,
          tabItems,
          selectedCallback: (value) {
            setState(() {
              selectTab = value!;
            });
          },
        ),
      ),
    );
    // bottomNavigationBar: buildCustomBottomAppBar(),
  }

  Future<void> loadSpinWheel() async {
    try {
      showLoaderDialog(context);
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      var list = await client.getSpins(data.userId ?? "");
      Navigator.pop(context);
      //
      if (list[0].spin_status != 0) {
        // showSnackBar(context, "Offers are not available");
        showBottomSheetMessage();
        return;
      }
      //
      Navigator.of(context).push(
        TutorialOverlay(
          child: WheelWidget(data: list[0]),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
    }
  }

  Future<void> showBottomSheetMessage() async {
    BuildContext mCtx;
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        constraints: BoxConstraints(minHeight: 100),
        child: Text("Offers are not available"),
      ),
    );
    // Future.delayed(Duration(seconds: 1), (){
    //
    // });
  }

  Widget buildCustomBottomAppBar() {
    return Stack(clipBehavior: Clip.none, children: <Widget>[
      CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 60.h),
        painter: BottomBarPainter(
            position: MediaQuery.of(context).size.width * selectTab,
            color: Colors.white,
            showShadow: false,
            notchColor: Colors.green.shade300),
      ),
      Positioned(
        left: kCircleRadius,
        top: kMargin,
        child: Icon(
          Icons.home,
          size: 20,
        ),
      ),
    ]);
  }
}

class GreenClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

//https://www.youtube.com/watch?v=xuatM4pZkNk
class GreenClipperReverse extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    //
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);

    // path.lineTo(0, height);
    // path.quadraticBezierTo(width / 2, height - 100, width, height);
    // path.lineTo(width, 0);

    // path.lineTo(width, 0);
    // path.lineTo(width, height);
    // path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
