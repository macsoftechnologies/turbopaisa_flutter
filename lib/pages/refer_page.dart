import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/model/WalletResponse.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({Key? key}) : super(key: key);

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  @override
  void initState() {
    super.initState();
    loadReferalCode();
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
          await client.getTransactions(data.userId ?? "");
      setState(() {
        this.walletResponse = scratchCardResponse;
      });
    } catch (e) {
      print(e);
    }
  }

  UserData? data;

  Future<void> loadReferalCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await prefs.getString("user");
    UserData data = UserData.fromJson(jsonDecode(user!));
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          "Refer & Earn",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.19,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(16),
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
                  width: 8,
                ),
                Text(
                  "₹ ${walletResponse?.wallet?.toStringAsFixed(2) ?? "0.00"}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   gradient: AppColors.appGradientBg,
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 67.h,
              ),
              Image.asset(
                "assets/images/refer_friend.png",
                width: 231.w,
                height: 169.h,
              ),
              SizedBox(
                height: 35.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Refer Now & Earn Up to',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.04,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.04,
                      ),
                    ),
                    TextSpan(
                      text: '₹ 350',
                      style: TextStyle(
                        color: Color(0xFFED3E55),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.04,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Send a referral link to your friends via \nWhatsApp / Facebook / Instagram',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF717171),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 1.66,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Column(
                children: [
                  Text(
                    "Your referral ID",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 24,
                      ),
                      DottedBorder(
                        dashPattern: [2, 3],
                        radius: Radius.circular(10),
                        borderType: BorderType.RRect,
                        color: Colors.black,
                        strokeWidth: 0.5,
                        // radius: Radius.circular(50),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 17.h),
                          child: Text(
                            "${data?.userUniqueId ?? "User id is missing"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 16,
                              // fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.04,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text:
                                  "${data?.userUniqueId ?? "User id is missing"}",
                            ),
                          );
                          HapticFeedback.mediumImpact();
                          showSnackBar(context, "Copied.");
                        },
                        child: Image.asset(
                          "assets/images/solar_copy_linear.png",
                          // fit: BoxFit.cover,
                          width: 20.w,
                        ),
                      ),
                    ],
                  )
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Container(
                  //           padding:
                  //               EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               border: Border.fromBorderSide(
                  //                   BorderSide(color: Colors.grey, width: 1))),
                  //           child: Text(
                  //             "TURBOPAISA03",
                  //             style: TextStyle(fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //
                  //         // Text(
                  //         //   "Tap to copy",
                  //         //   style: TextStyle(color: Colors.grey, fontSize: 12),
                  //         // ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Image.asset(
                  //       "assets/images/solar_copy_linear.png",
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  await FlutterShare.share(
                      title: 'Share',
                      text: 'Try the best application to earn cash.',
                      linkUrl:
                          "http://turbopaisa.com/referal?code=${data?.userUniqueId ?? "User id is missing"}",
                      chooserTitle: 'Share');
                },
                child:
                Container(
                  width: 250,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: Color(0xFFED3E55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.67),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        // fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.38,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   width: 260,
                //   padding: EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     color: AppColors.accentColor,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Center(
                //     child: Padding(
                //       padding: const EdgeInsets.all(6.0),
                //       child: Text(
                //         "Share",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
