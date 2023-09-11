import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/OffersData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferDetailsPage extends StatefulWidget {
  OffersData data;

  OfferDetailsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  bool isTaskLoading = false;

  @override
  void initState() {
    super.initState();
    loadOfferDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.data.offerTitle ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.19,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.appLoginGradientBg),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(10),
              //   child: Image.network(widget.data.images![0].image.toString(),
              //       fit: BoxFit.cover,
              //       width: double.infinity,
              //       height: 130.h,
              //       errorBuilder: (context, error, stackTrace) => Image.asset(
              //             placeHolder,
              //             height: 130.h,
              //           )),
              // ),
              Container(
                width: 335.w,
                height: 130.h,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(widget.data.images![0].image.toString()),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.67),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 38.33,
                      offset: Offset(2.32, 8),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.offerTitle ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        // widget.data.offerTagline ?? "",
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.38,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _launchUrl(widget.data.url ?? "");
                    },
                    child: Container(
                      constraints: BoxConstraints(minWidth: 83.w),
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFED3E55),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Center(
                        child: Text(
                          "Get ₹ ${widget.data.offerAmount}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Divider(
                thickness: 1.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About application",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.38,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                      // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum doloreLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore",
                      widget.data.offerDesc ?? "",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                thickness: 1,
                indent: 1,
                endIndent: 1,
              ),
              SizedBox(
                height: 10.h,
              ),
              isTaskLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 1,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildTask(
                          index + 1,
                          offerDetails?.tasks?.length ?? 0,
                          offerDetails?.tasks![index]),
                      itemCount: offerDetails?.tasks?.length ?? 0,
                    ),
              // buildTask(),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1.h,
              ),
              SizedBox(
                height: 30,
              ),
              //Spacer(),
              if (offerDetails?.availedusers != 0)
                RichText(
                  text: TextSpan(
                    text: offerDetails?.availedusers.toString() ?? "",
                    style: TextStyle(
                      color: Color(0xFFED3E55),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Users have already participated',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 20.h,
              ),

              InkWell(
                onTap: () {
                  _launchUrl(widget.data.url ?? "");
                },
                child: Container(
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
                      'Register Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.33,
                        fontWeight: FontWeight.w600,
                        height: 1.24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Column buildTask(int index, int total, Tasks? task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              task?.isShow = !(task.isShow!);
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Task (${index}/${total})",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.38,
                  ),
                ),
                Icon(task?.isShow == true
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up)
              ],
            ),
          ),
        ),
        if (task?.isShow == true) ...showOrHideTask(task, index != (total)),
      ],
    );
  }

  List<Widget> showOrHideTask(Tasks? task, bool isLastItem) {
    return [
      SizedBox(
        height: 12.h,
      ),
      Text(
        // "Install Now ",
        task?.taskName ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Text(
        // "Install the app in your smartphone",
        task?.description ?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      if (isLastItem) Divider(),
    ];
  }

  HtmlEscape htmlEscape = HtmlEscape();

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      // throw Exception('Could not launch $_url');
      showSnackBar(context, 'Could not launch $_url');
    }
  }

  OffersData? offerDetails;

  Future<void> loadOfferDetails() async {
    //getOfferDetailsById
    try {
      setState(() {
        isTaskLoading = true;
      });
      final client = await RestClient.getRestClient();

      Map<String, String> body = HashMap();
      body.putIfAbsent("offer_id", () => widget.data.offerId ?? "");

      List<OffersData> response = await client.getOfferDetailsById(body);
      response.first.tasks?.forEach((e) {
        e.isShow = true;
      });
      if (response.isNotEmpty) {
        setState(() {
          offerDetails = response.first;
        });
      }
    } catch (e) {}
    setState(() {
      isTaskLoading = false;
    });
  }
}
