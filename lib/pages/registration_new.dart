import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offersapp/generated/assets.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 62.sp),
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
                height: 63.h,
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
                height: 16.sp,
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
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20.w,
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
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 20.w,
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
                  prefixIcon: Icon(
                    Icons.phone,
                    size: 20.w,
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
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: "Referral Code (optional)",
              //     prefixIcon: Padding(
              //       padding:  EdgeInsets.only(right: 20.w),
              //       child: Icon(
              //         Icons.group,
              //         size: 20.w,
              //       ),
              //     ),
              //     prefixIconConstraints: BoxConstraints(minWidth: 50.w,),
              //   ),
              //   style: textStyle.copyWith(
              //     color: Color(0xFF8C8C8C),
              //   ),
              // ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Referral Code (optional)",
                  prefixIcon: Icon(
                    Icons.group,
                    size: 20.w,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
