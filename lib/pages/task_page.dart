import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/OffersData.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/pages/offer_details_page.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:offersapp/widgets/banner_ad.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/BannersResponse.dart';
import '../api/restclient.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isLoading = false;
  int _selectedIndex = 0;

  var groupValue = 0;

  // List<OffersData> offersData = [];
  List<BannerData> banners = [];

  @override
  void initState() {
    super.initState();
    loadData();
    loadBannersData();
  }

  List<OffersData> allOffers = [];
  List<OffersData> myOffers = [];
  List<OffersData> upcomingOffers = [];

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      var list = await client.getOffers(data.userId ?? "");
      //Insert add placements [START]
      var tempList = <OffersData>[];
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && i % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
      }
      //Insert add placements [END]
      setState(() {
        allOffers = tempList;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadBannersData() async {
    try {
      final client = await RestClient.getRestClient();
      var list = await client.getBanners("home");
      setState(() {
        banners = list.banner?.cast<BannerData>() ?? [];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Task',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              buildSegmentedControl(context),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              if (_selectedIndex == 0) buildAllOffers(allOffers),
              if (_selectedIndex == 1) buildAllOffers(myOffers),
              if (_selectedIndex == 2) buildAllOffers(upcomingOffers),
              buildBanners(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildSegmentedControl(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.fromBorderSide(
            BorderSide(width: 2, color: Colors.white.withOpacity(0.4)),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 0))
          ]),
      child: CupertinoSlidingSegmentedControl<int>(
        backgroundColor: CupertinoColors.white,
        thumbColor: Colors.red,
        // padding: EdgeInsets.all(8),
        groupValue: groupValue,
        children: {
          0: buildSegment(0, "All Offers"),
          1: buildSegment(1, "My Offers"),
          2: buildSegment(2, "Upcoming"),
        },
        onValueChanged: (value) {
          setState(() {
            groupValue = value!;
            _selectedIndex = value;
            print(value);
            if (_selectedIndex == 0) {
              loadData();
            } else if (_selectedIndex == 1) {
              loadMyOffersData();
            } else if (_selectedIndex == 2) {
              loadUpcomingOffers();
            }
          });
        },
      ),
    );
  }

  Widget buildSegment(int index, String text) {
    return Container(
      // padding: EdgeInsets.all(8),
      height: 35.h,
      child: Center(
        child: Text(
          text,
          style: _selectedIndex == index
              ? TextStyle(
                  color: Colors.white,
                  fontSize: 9.sp,
                  // fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.84,
                )
              : TextStyle(
                  color: Colors.black,
                  fontSize: 9.sp,
                  // fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.84,
                ),
          // TextStyle(
          //   color: _selectedIndex == index ? Colors.white : Colors.black,
          //   fontSize: _selectedIndex == index ? 14 : 12,
          // ),
        ),
      ),
    );
  }

  Widget buildSegmentButtons() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.fromBorderSide(
            BorderSide(width: 2, color: Colors.white.withOpacity(0.4)),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSegmentedButton(0, "All Offers"),
          buildSegmentedButton(1, "My Offers"),
          buildSegmentedButton(2, "Upcoming"),
        ],
      ),
    );
  }

  Widget buildSegmentedButton(int index, String name) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        decoration: BoxDecoration(
            color: _selectedIndex == index ? Colors.indigo : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(12),
        duration: Duration(milliseconds: 300),
        child: Text(
          name,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.black,
            fontSize: _selectedIndex == index ? 14 : 12,
          ),
        ),
      ),
    );
  }

  Widget buildAllOffers(List<OffersData> offersData) {
    return (offersData.length == 0 && !isLoading)
        ? Container(
            constraints: BoxConstraints(minHeight: 200),
            child: Center(
              child: Text(
                "No Offers Available.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  // fontFamily: 'Poppins',
                  height: 1.38,
                ),
              ),
            ),
          )
        : ListView.builder(
            key: UniqueKey(),
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (offersData[index].isBanner == true) {
                return BannerAdWidget();
              }
              return InkWell(
                onTap: () {
                  navigateToNext(
                      context, OfferDetailsPage(data: offersData[index]));
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.w),
                  width: 335,
                  height: 87,
                  decoration: ShapeDecoration(
                    color: Colors.white,
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
                  child: Row(
                    children: [
                      Container(
                        width: 100.w,
                        height: 75.h,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                offersData[index].images![0].image.toString()),
                            fit: BoxFit.cover,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      ),
                      SizedBox(
                        width: 23.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              offersData[index].offerTitle ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                // fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.38,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              offersData[index].offerDesc ?? "",
                              maxLines: 2,
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 8,
                                // fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            Text(
                              "₹ ${offersData[index].offerAmount ?? ""}",
                              style: TextStyle(
                                color: Color(0xFFED3E55),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: offersData.length);
  }

  PageController _pageController =
      new PageController(initialPage: 0, viewportFraction: 0.8);

  Widget buildBanners() {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 133.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: banners.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    banners[index].bannerImage ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Center(
            //     child: Text(
            //         "${(index + 1).toString() ?? ""}/${banners.length.toString()}"))
          ],
        ),
      ),
    );
  }

  Future<void> loadMyOffersData() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      Map<String, String> body = HashMap();
      body.putIfAbsent("user_id", () => data.userId.toString());

      final client = await RestClient.getRestClient();
      var list = await client.getMyOffer(body);
      //Insert add placements [START]
      var tempList = <OffersData>[];
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && i % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
      }
      //Insert add placements [END]
      setState(() {
        // offersData = list;
        myOffers = tempList;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadUpcomingOffers() async {
    try {
      setState(() {
        isLoading = true;
      });
      final client = await RestClient.getRestClient();
      var list = await client.getUpComingOffers();
      //Insert add placements [START]
      var tempList = <OffersData>[];
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && i % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
      }
      //Insert add placements [END]

      setState(() {
        // offersData = list;
        upcomingOffers = tempList;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }
}
