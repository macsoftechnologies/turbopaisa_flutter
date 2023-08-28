import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:offersapp/api/model/UserData.dart';
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
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      // decoration: BoxDecoration(
      //   gradient: AppColors.appGradientBg,
      // ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/images/refer_friend.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Refer Now & Earn Up to",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    " ₹ 350",
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ],
              ),
              Text(
                "Send a referral link to your friends via",
                style: TextStyle(color: Colors.black.withOpacity(0.4)),
              ),
              Text("WhatsApp / Facebook / Instagram",
                  style: TextStyle(color: Colors.black.withOpacity(0.4))),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Column(
            children: [
              Text(
                "Your referral ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  DottedBorder(
                    dashPattern: [5, 5],
                    radius: Radius.circular(10),
                    borderType: BorderType.RRect,
                    color: Colors.black,
                    strokeWidth: 0.3,
                    // radius: Radius.circular(50),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "${data?.userUniqueId ?? "User id is missing"}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  InkWell(
                    onTap: () async {

                      await Clipboard.setData(
                        ClipboardData(
                          text: "${data?.userUniqueId ?? "User id is missing"}",
                        ),
                      );
                      HapticFeedback.mediumImpact();
                      showSnackBar(context, "Copied.");
                    },
                    child: Image.asset(
                      "assets/images/solar_copy_linear.png",
                      // fit: BoxFit.cover,
                      width: 20,
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
            child: Container(
              width: 260,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
