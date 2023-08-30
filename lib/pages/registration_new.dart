import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:offersapp/pages/dashboard_page.dart';

class RegistrationPageNew extends StatefulWidget {
  const RegistrationPageNew({Key? key}) : super(key: key);

  @override
  State<RegistrationPageNew> createState() => _RegistrationPageNewState();
}

class _RegistrationPageNewState extends State<RegistrationPageNew> {
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

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
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
                              'Registration',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
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
                      Text(
                        'Username',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintStyle: textStyle.copyWith(
                            color: Color(0xFF8C8C8C),
                          ),
                          hintText: "Type your name",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Icon(
                              Icons.person,
                              size: 20.w,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'Password ',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Icon(
                              Icons.lock,
                              size: 20.w,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'Phone ',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Type your phone number",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Icon(
                              Icons.phone,
                              size: 20.w,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      SizedBox(
                        height: commonSpace,
                      ),
                      Text(
                        'Referral Code',
                        style: h1textStyle,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Referral Code (optional)",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 20.w),
                            child: Icon(
                              Icons.group,
                              size: 20.w,
                            ),
                          ),
                          prefixIconConstraints: BoxConstraints(minWidth: 30.w),
                        ),
                        style: textStyle.copyWith(
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      SizedBox(
                        height: 44.sp,
                      ),
                      Container(
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
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.19,
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
}
