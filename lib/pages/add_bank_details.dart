import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offersapp/api/model/BankDetailsResponse.dart';
import 'package:offersapp/api/model/RegistrationResponse.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/ChangePasswordResponse.dart';

class AddBankDetailsPage extends StatefulWidget {
  const AddBankDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddBankDetailsPage> createState() => _AddBankDetailsPageState();
}

class _AddBankDetailsPageState extends State<AddBankDetailsPage> {
  TextEditingController _upiId = new TextEditingController();
  TextEditingController _accountNumber = new TextEditingController();
  TextEditingController _ifscCode = new TextEditingController();
  TextEditingController _bankName = new TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    var commonSpace = 16.h;
    var textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10.sp,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 1.66,
    );

    var h1textStyle = TextStyle(
      color: Colors.black,
      fontSize: 10.sp,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 1.66,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          // rgba(224, 234, 255, 0.48), rgba(224, 234, 255, 0.52), rgba(224, 234, 255, 1)
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(224, 234, 255, 0.48),
                  Color.fromRGBO(224, 234, 255, 0.52),
                  Color.fromRGBO(224, 234, 255, 1),
                ]),
          ),
          // padding: EdgeInsets.symmetric(horizontal: 62.sp),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: RotatedBox(
                  quarterTurns: 90,
                  child: ClipPath(
                    clipper: GreenClipperReverse(),
                    child: Container(
                      height: 115.h,
                      color: Color(0xff222467),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
                  child: Icon(Icons.arrow_back_rounded),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 62.sp),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 21.h,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/turbopaisa_logo_two.png",
                          height: 69.h,
                        ),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(
                              Assets.svgRegisterRectangle,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'Add Payment Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                // height: 0.97,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                      if (isLoading)
                        Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 1,
                        )),
                      Text(
                        'Enter your UPI ID',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your UPI ID",
                          hintStyle: textStyle.copyWith(
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Colors.black,
                        ),
                        controller: _upiId,
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'Account Number',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your Account number",
                          hintStyle: textStyle.copyWith(
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Colors.black,
                        ),
                        controller: _accountNumber,
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'IFSC Code',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your IFSC Code",
                          hintStyle: textStyle.copyWith(
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Colors.black,
                        ),
                        controller: _ifscCode,
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'Bank Name',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your Bank Name",
                          hintStyle: textStyle.copyWith(
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Colors.black,
                        ),
                        controller: _bankName,
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      if(!isLoading)
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          submitData();
                        },
                        child: Container(
                          width: 250.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFED3E55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.67),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.19,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, top: 40.w),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/coin.png",
                              // width: 80,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            "assets/images/coin_two.png",
                            //width: 80,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      if (_upiId.text.isNotEmpty ||
          (_accountNumber.text.isNotEmpty &&
              _ifscCode.text.isNotEmpty &&
              _bankName.text.isNotEmpty)) {
        showLoaderDialog(context);
        final client = await RestClient.getRestClient();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var user = await prefs.getString("user");
        UserData userData = UserData.fromJson(jsonDecode(user!));
        Map<String, String> body = HashMap();
        body.putIfAbsent("user_id", () => userData.userId.toString());
        body.putIfAbsent("bank_account", () => _accountNumber.text.trim());
        body.putIfAbsent("bank_ifsc", () => _ifscCode.text.trim());
        body.putIfAbsent("bank_name", () => _bankName.text.trim());
        body.putIfAbsent("upi_id", () => _upiId.text.trim());

        ChangePasswordResponse data = await client.addBeneficiary(body);
        if (data.status != 200) {
          showSnackBar(context, data.result ?? "");
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          showSnackBar(context, data.message ?? "");
        }
      } else {
        showSnackBar(context, "Enter UPI Id/All Bank details");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Failed to save bank details.");
      Navigator.pop(context);
    }
  }

  Future<void> loadData() async {
    try {
      // showLoaderDialog(context);
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData userData = UserData.fromJson(jsonDecode(user!));
      Map<String, String> body = HashMap();
      body.putIfAbsent("user_id", () => userData.userId.toString());

      List<BankDetailsResponse> data =
          await client.getBeneficiaryDetailsById(body);
      if (data.isNotEmpty) {
        BankDetailsResponse detailsResponse = data.first;
        setState(() {
          _upiId.text = detailsResponse.upiId ?? "";
          _accountNumber.text = detailsResponse.accountNumber ?? "";
          _ifscCode.text = detailsResponse.ifscCode ?? "";
          _bankName.text = detailsResponse.bankName ?? "";
        });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }
}
