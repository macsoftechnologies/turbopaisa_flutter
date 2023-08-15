import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:offersapp/pages/LoginPage.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/UserData.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  UserData? userData;

  Future<void> loadProfile() async {
    try {
      print("loadProfile: called");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      setState(() {
        userData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: AppColors.appGradientBg,
        ),

        //color: Colors.lightBlueAccent.withOpacity(0.2),
        // padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // SizedBox(
          //   height: 20,
          // ),
          Stack(
            children: [
              ClipPath(
                clipper: GreenClipper(),
                child: Container(
                  height: 150,
                  color: Color(0xff3D3FB5),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 68,
                    ),
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/proflie_image.png',
                        fit: BoxFit.cover,
                        width: 110,
                        // height: 200,
                        //height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      userData?.name?.toUpperCase() ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(userData?.email ?? ""),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Image.asset(
                      'assets/images/language_icon.png',
                      //width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Language",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "ENG",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/rate_us_icon.png',
                      //width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Rate Us",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/support_icon.png',
                      //width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Support",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/up_arrow.png',
                      //width: 20,
                    ),
                  ),
                ],
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/privacy_policy.png',
                      // width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ],
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/images/terms_conditions.png',
                      //width: 20,
                    ),
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    "Terms & Conditions",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ],
              ),

              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove("user");
                  navigateToNextReplace(context, LoginPage());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.asset(
                        'assets/images/log_out_icon.png',
                      ),
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Text(
                      "Log out",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Follow Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Image.asset(
                        'assets/images/facebook_logo.png',
                        fit: BoxFit.cover,
                        width: 30,
                        //height: 40,
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Image.asset(
                        'assets/images/instagram_logo.png',
                        fit: BoxFit.cover,
                        width: 26,
                      ),
                    ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Image.asset(
                        'assets/images/youtube_logo.png',
                        fit: BoxFit.cover,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ),

              // buildRow(Icons.language, "Languages"),
              // Divider(),
              //         buildRow(Icons.edit, "Edit Profile"),
              //         Divider(),
              //         buildRow(Icons.star_rate, "Rate Us"),
              //         Divider(),
              //         buildRow(Icons.support_agent, "Support"),
              //         Divider(),
              //         buildRow(Icons.privacy_tip, "Privacy Policy"),
              //         Divider(),
              //         buildRow(Icons.document_scanner, "Terms and Conditions"),
              //         Divider(),
              //         InkWell(
              //             onTap: () {
              //               logout();
              //             },
              //             child: buildRow(Icons.logout, "Logout")),
              //         Divider(),
              //         Spacer(),
              //         Padding(
              //           padding: const EdgeInsets.all(16.0),
              //           child: Center(child: Text("Version: 1.0.0")),
              //         )
              //       ],
              //     ),
              //   );
              // }
              //
              // Widget buildRow(IconData data, String title) {
              //   return Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       children: [
              //         Icon(
              //           data,
              //           color: Colors.blue,
              //         ),
              //         SizedBox(
              //           width: 16,
              //         ),
              //         Text(title),
              //         Spacer(),
              //         Icon(
              //           Icons.arrow_forward_ios_rounded,
              //           size: 16,
              //           color: Colors.blue,
              //         ),
              //       ],
              //     ),
              //   );
            ]),
          ),
        ]),
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
