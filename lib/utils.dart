import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:url_launcher/url_launcher.dart';

const titleHeaderColor = Colors.teal;

// const primaryColor = Color(0xFF072B4C);
const orangeColor = Color(0xFFF2BA47);
const placeHolder = Assets.imagesTurbopaisaLogoTwo;
const Color lightGrey = Color.fromRGBO(242, 242, 242, 1);
//http://mcg.mbitson.com/
const MaterialColor mcgpalette0 =
    MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
  50: Color(0xFFE1E6EA),
  100: Color(0xFFB5BFC9),
  200: Color(0xFF8395A6),
  300: Color(0xFF516B82),
  400: Color(0xFF2C4B67),
  500: Color(_mcgpalette0PrimaryValue),
  600: Color(0xFF062645),
  700: Color(0xFF05203C),
  800: Color(0xFF041A33),
  900: Color(0xFF021024),
});
const int _mcgpalette0PrimaryValue = 0xFF072B4C;

const MaterialColor mcgpalette0Accent =
    MaterialColor(_mcgpalette0AccentValue, <int, Color>{
  100: Color(0xFF5F92FF),
  200: Color(_mcgpalette0AccentValue),
  400: Color(0xFF004FF8),
  700: Color(0xFF0047DF),
});
const int _mcgpalette0AccentValue = 0xFF2C6FFF;

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 1000),
    ),
  );
}

navigateToNext(BuildContext context, Widget target) {
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context) {
        return target;
      },
    ),
  );
}

navigateToNextReplace(BuildContext context, Widget target) {
  Navigator.of(context).pushReplacement(
    new MaterialPageRoute(
      builder: (context) {
        return target;
      },
    ),
  );
}

showLoaderDialog(BuildContext context, {String? message}) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(
            message ?? "Pleas wait...",
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget getNetworkImage(String? imageUrl,
    {double? width,
    double? height,
    String? placeholder,
    BoxFit? fit,
    Key? key}) {
  return CachedNetworkImage(
    width: width ?? double.infinity,
    height: height ?? double.infinity,
    imageUrl: imageUrl ?? "",
    fit: fit ?? BoxFit.cover,
    key: key,
    placeholder: (context, url) => new Image(
      fit: BoxFit.cover,
      image: AssetImage(placeholder ?? Assets.imagesAppLogo),
      height: double.infinity,
    ),
    errorWidget: (context, url, error) => new Image(
        fit: BoxFit.cover,
        image: AssetImage(placeholder ?? Assets.imagesAppLogo)),
  );
}

Future<void> launchUrlBrowser(BuildContext context, String _url) async {
  print("launchUrlBrowser: called");
  if (!await launchUrl(Uri.parse(_url), mode: LaunchMode.externalApplication)) {
    // throw Exception('Could not launch $_url');
    showSnackBar(context, 'Could not launch $_url');
  }
}
