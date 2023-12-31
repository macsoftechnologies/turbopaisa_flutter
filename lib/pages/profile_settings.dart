import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/WalletResponse.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/pages/LoginPage.dart';
import 'package:offersapp/pages/add_bank_details.dart';
import 'package:offersapp/pages/change_password.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/pages/privacy_policy.dart';
import 'package:offersapp/pages/terms_and_condtions.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/model/UserData.dart';
import '../generated/assets.dart';

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
    loadWallet();
  }

  WalletResponse? walletResponse;

  Future<void> loadWallet() async {
    try {
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      WalletResponse scratchCardResponse =
          await client.getTransactions(data.userId ?? "",1,1);
      setState(() {
        this.walletResponse = scratchCardResponse;
      });
    } catch (e) {
      print(e);
    }
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
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      // fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 1.38,
    );

    return SingleChildScrollView(
      child: Container(
        // padding: EdgeInsets.all(10),
        // height: MediaQuery.of(context).size.height,
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
                  height: 150.h,
                  color: Color(0xff3D3FB5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ClipRRect(
                    //   child: Image.asset(
                    //     'assets/images/proflie_image.png',
                    //     fit: BoxFit.cover,
                    //     width: 45,
                    //     // height: 200,
                    //     //height: 100,
                    //   ),
                    // ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        // fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.19,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        // margin: EdgeInsets.all(5),2
                        color: AppColors.primaryDarkColor.withOpacity(0.5),
                      ),
                      // padding: EdgeInsets.all(20),
                      padding: EdgeInsets.only(right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Image.asset(
                                color: Colors.black,
                                'assets/images/wallet_icon.png',
                                fit: BoxFit.contain,
                                width: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "₹ ${walletResponse?.wallet?.toStringAsFixed(2) ?? "0.00"}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ],
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
                        'assets/images/profile_avatar.png',
                        width: 88.w,
                        // height: 200,
                        //height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      userData?.name?.toUpperCase() ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        // fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.04,
                      ),
                    ),
                    Text(userData?.email ?? "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          // fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.66,
                        )),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(
              //         left: 20,
              //       ),
              //       child: Image.asset(
              //         'assets/images/language_icon.png',
              //         //width: 20,
              //       ),
              //     ),
              //     SizedBox(
              //       width: 20,
              //     ),
              //     Text(
              //       "Language",
              //       style: TextStyle(fontWeight: FontWeight.w600),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 10),
              //       child: Text(
              //         "ENG",
              //         style: TextStyle(fontSize: 16),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(
              //   //width: 5,
              //   color: Colors.black12,
              //   thickness: 1,
              //   height: 30,
              //   indent: 10.0,
              //   endIndent: 10.0,
              // ),
              InkWell(
                onTap: () {
                  navigateToNext(context, ChangePasswordPage());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Icon(
                        Icons.lock,
                        size: 20.w,
                      ),
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Text(
                      "Update Password",
                      style: textStyle,
                    )
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30.h,
                indent: 10.0,
                endIndent: 10.0,
              ),

              InkWell(
                onTap: () {
                 navigateToNext(context, AddBankDetailsPage());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Icon(
                        Icons.security,
                        size: 20.w,
                      ),
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Text(
                      "Payment Details",
                      style: textStyle,
                    )
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30.h,
                indent: 10.0,
                endIndent: 10.0,
              ),

              InkWell(
                onTap: () {
                  showSnackBar(context, "App is not available in Store.");
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        'assets/images/rate_us_icon.png',
                        //width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Text(
                      "Rate Us",
                      style: textStyle,
                    )
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30.h,
                indent: 10.0,
                endIndent: 10.0,
              ),


              InkWell(
                onTap: () {
                  showSnackBar(context, "Coming soon!");
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        'assets/images/support_icon.png',
                        //width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Support",
                      style: textStyle,
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Image.asset(
                        'assets/images/up_arrow.png',
                        //width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30.h,
                indent: 10.0,
                endIndent: 10.0,
              ),
              InkWell(
                onTap: () {
                  navigateToNext(context, PrivacyPolicyPage());
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Image.asset(
                        'assets/images/privacy_policy.png',
                        // width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      "Privacy Policy",
                      style: textStyle,
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),
              Divider(
                //width: 5,
                color: Colors.black12,
                thickness: 1,
                height: 30.h,
                indent: 10.0,
                endIndent: 10.0,
              ),
              InkWell(
                onTap: () {
                  navigateToNext(context, TermsAndConditionsPage());
                },
                child: Row(
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
                      style: textStyle,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
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
                      style: textStyle,
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
                height: 35.h,
              ),
              Text(
                "Follow Us",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchUrl(context, "http://www.facebook.com");
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/facebook_logo.png',
                          fit: BoxFit.cover,
                          width: 30,
                          //height: 40,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(context, "http://www.instagram.com");
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/instagram_logo.png',
                          fit: BoxFit.cover,
                          width: 26,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchUrl(context, "http://www.youtube.com");
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/youtube_logo.png',
                          fit: BoxFit.cover,
                          width: 30,
                        ),
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

  Future<void> _launchUrl(BuildContext context, String _url) async {
    if (!await launchUrl(Uri.parse(_url),
        mode: LaunchMode.externalApplication)) {
      // throw Exception('Could not launch $_url');
      showSnackBar(context, 'Could not launch $_url');
    }
  }
}
