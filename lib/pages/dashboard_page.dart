import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int selectedPos = 0;

  int selectTab = 0;

  late CircularBottomNavigationController _navigationController;

  late double _screenWidth;
  late final AnimationController _animationController;
  late NotchBottomBarController notchBottomBarController;

  @override
  void initState() {
    super.initState();
    notchBottomBarController = NotchBottomBarController(index: 0);
    _navigationController = CircularBottomNavigationController(selectedPos);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // kHeight = 62.0;
    // kMargin = 14.0;
    notchBottomBarController.addListener(() {
      print("addListener called!");
      _animationController.reset();
      _animationController.forward();
      setState(() {
        selectTab = notchBottomBarController.index;
        print("selected ${selectTab}");
      });
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const WalletBalacePage(),
    const ReferPage(),
    const ProfileSettingsPage()
  ];

  Widget getPage(int index) {
    print(index);
    // return Text('$index');
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
    _screenWidth = MediaQuery.of(context).size.width;
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
          : Padding(
              padding: EdgeInsets.only(bottom: 135.h),
              child: InkWell(
                onTap: () {
                  loadSpinWheel();
                },
                child: Image.asset(
                  Assets.imagesFabWheel,
                  width: 80,
                ),
              ),
            ),
      // backgroundColor: AppColors.appGradientBg ,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 60.h),
              decoration: BoxDecoration(gradient: AppColors.appGradientBg),
              child: Column(
                children: [
                  Expanded(child: getPage(selectTab)),
                  SizedBox(
                    height: 65.h,
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 0, left: 0, right: 0, child: buildCustomBottomAppBar()),
          ],
        ),
      ),
      //   bottomNavigationBar: SafeArea(
      //     child: CircularBottomNavigation(
      //       controller: _navigationController,
      //       tabItems,
      //       selectedCallback: (value) {
      //         setState(() {
      //           selectTab = value!;
      //         });
      //       },
      //     ),
      //   ),
      // );

      // bottomNavigationBar: buildCustomBottomAppBar(),
    );
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
      if (list.isNotEmpty) {
        Navigator.of(context).push(
          TutorialOverlay(
            child: WheelWidget(data: list.first),
          ),
        );
      } else {
        showSnackBar(context, "No Spins are available.");
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, "Failed to load Spins.");
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

  // int oldIndex = -1;
  // int index = 0;
  bool _isInitial = true;

  var tabs = [
    {
      "title": "Home",
      "icon": Assets.svgTabsHome,
    },
    {
      "title": "My Wallet",
      "icon": Assets.svgTabsWallet,
    },
    {
      "title": "Refer & Earn",
      "icon": Assets.svgTabsShare,
    },
    {
      "title": "My Profile",
      "icon": Assets.svgTabsProfile,
    },
  ];

  Widget buildCustomBottomAppBar() {
    return AnimatedBuilder(
      builder: (BuildContext _, Widget? __) {
        ///to set any initial page
        double scrollPosition = notchBottomBarController.index.toDouble();
        int? currentIndex = notchBottomBarController.index;
        if (notchBottomBarController.oldIndex != null) {
          _isInitial = false;
          scrollPosition = Tween<double>(
                  begin: notchBottomBarController.oldIndex!.toDouble(),
                  end: notchBottomBarController.index.toDouble())
              // ignore: invalid_use_of_protected_member
              .lerp(_animationController.value);
          currentIndex = notchBottomBarController.index;
        } else {
          scrollPosition = notchBottomBarController.index.toDouble();
          currentIndex = notchBottomBarController.index;
        }
        var height = kHeight + kMargin * 2;
        return Stack(clipBehavior: Clip.none, children: <Widget>[
          CustomPaint(
            size: Size(_screenWidth, height.h),
            painter: BottomBarPainter(
                position: _itemPosByScrollPosition(scrollPosition),
                color: Colors.white,
                showShadow: false,
                notchColor: Colors.white),
          ),
          for (var i = 0; i < 4; i++) ...[
            if (i == currentIndex &&
                (_animationController.value == 1.0 || _isInitial))
              Positioned(
                top: -kCircleMargin / 2, //kTopMargin,
                left: kCircleRadius -
                    kCircleMargin / 2 +
                    _itemPosByScrollPosition(scrollPosition),
                child: InkWell(
                  onTap: () {
                    notchBottomBarController.jumpTo(i);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        tabs[i]['icon'] ?? "",
                        height: 23,
                        width: 23,
                        color: Color(0xFFED3E55),
                      ),
                    ],
                  ),
                ),
              ),
            if (i != currentIndex)
              Positioned(
                top: kMargin + (kHeight - kCircleRadius * 2) / 2 + 5,
                left: kCircleMargin + _itemPosByIndex(i),
                child: InkWell(
                  onTap: () {
                    print(i);
                    notchBottomBarController.jumpTo(i);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        tabs[i]['icon'] ?? "",
                        height: 23,
                        width: 23,
                      ),
                    ],
                  ),
                ),
              ),
          ],
          for (var i = 0; i < 4; i++)
            if (i == currentIndex)
              Positioned(
                bottom: 10,
                left: kCircleMargin + _itemPosByIndex(i),
                child: Column(
                  children: [
                    Text(
                      tabs[i]['title'] ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFED3E55),
                      ),
                    ),
                  ],
                ),
              ),
        ]);
      },
      animation: _animationController,
    );
  }

  int bottomBarItems = 4;

  double _firstItemPosition(double spaceParameter) {
    return (_screenWidth - kMargin * 2) * spaceParameter;
  }

  double _lastItemPosition(double spaceParameter) {
    return _screenWidth -
        (_screenWidth - kMargin * 2) * spaceParameter -
        (kCircleRadius + kCircleMargin) * 2;
  }

  double _itemDistance() {
    return (_lastItemPosition(0.05) - _firstItemPosition(0.05)) /
        (bottomBarItems - 1);
  }

  double _itemPosByScrollPosition(double scrollPosition) {
    return _firstItemPosition(0.05) + _itemDistance() * scrollPosition;
  }

  double _itemPosByIndex(int index) {
    return _firstItemPosition(0.05) + _itemDistance() * index;
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

class NotchBottomBarController extends ChangeNotifier {
  int index;
  int? oldIndex;

  NotchBottomBarController({this.index = 0});

  jumpTo(int index) {
    oldIndex = this.index;
    this.index = index;
    notifyListeners();
  }
}
