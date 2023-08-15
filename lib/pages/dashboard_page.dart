import 'dart:io';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:offersapp/pages/HomePage.dart';
import 'package:offersapp/pages/profile_settings.dart';
import 'package:offersapp/pages/refer_page.dart';
import 'package:offersapp/pages/top_profile.dart';
import 'package:offersapp/pages/wallet_page.dart';
import 'package:offersapp/utils/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectTab = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const WalletBalacePage(),
    const ReferPage(),
    const ProfileSettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: selectTab != 0
          ? null
          : Image.asset(
              Assets.imagesFabWheel,
              width: 80,
            ),
      // backgroundColor: AppColors.appGradientBg ,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.appGradientBg),
          child: Column(
            children: [
              // if (selectTab != 3) TopProfileAppBarWidget(),
              Expanded(
                child: IndexedStack(
                  index: selectTab,
                  children: _widgetOptions,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: Platform.isIOS ? 70 : 65,
        color: Colors.transparent,
        padding: const EdgeInsets.all(0),
        child: Container(
          height: Platform.isIOS ? 70 : 65,
          decoration: const BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabNewButton(
                  icon: Icons.home,
                  // icon: "assets/images/home_icon.png",
                  // selectIcon: "assets/images/home_select_icon.png",
                  isActive: selectTab == 0,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 0;
                      });
                    }
                  }),
              TabNewButton(
                  icon: Icons.wallet,
                  // icon: "assets/images/activity_icon.png",
                  // selectIcon: "assets/images/activity_select_icon.png",
                  isActive: selectTab == 1,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 1;
                      });
                    }
                  }),
              TabNewButton(
                  icon: Icons.share_outlined,
                  // icon: "assets/images/camera_icon.png",
                  // selectIcon: "assets/images/camera_select_icon.png",
                  isActive: selectTab == 2,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 2;
                      });
                    }
                  }),
              TabNewButton(
                  icon: Icons.person,
                  // icon: "assets/images/user_icon.png",
                  // selectIcon: "assets/images/user_select_icon.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        selectTab = 3;
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class TabNewButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const TabNewButton(
      {Key? key,
      required this.icon,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: 80,
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isActive ? 32 : 25,
              color: isActive ? AppColors.accentColor : Colors.grey,
            ),
            SizedBox(height: isActive ? 8 : 12),
            Visibility(
              visible: isActive,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.accentColor,
                      AppColors.accentColor,
                    ]),
                    borderRadius: BorderRadius.circular(2)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String icon;
  final String selectIcon;
  final bool isActive;
  final VoidCallback onTap;

  const TabButton(
      {Key? key,
      required this.icon,
      required this.selectIcon,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isActive ? selectIcon : icon,
              width: 25,
              height: 25,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: isActive ? 8 : 12),
            Visibility(
              visible: isActive,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.secondaryG),
                    borderRadius: BorderRadius.circular(2)),
              ),
            )
          ],
        ),
      ),
    );
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
