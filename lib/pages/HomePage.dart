import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/OffersData.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/model/WalletResponse.dart';
import 'package:offersapp/generated/assets.dart';
import 'package:offersapp/pages/earn_on_games.dart';
import 'package:offersapp/pages/offer_details_page.dart';
import 'package:offersapp/pages/scratch_card_list_page.dart';
import 'package:offersapp/pages/scratch_card_page.dart';
import 'package:offersapp/pages/task_page.dart';
import 'package:offersapp/pages/tutorial_page.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:offersapp/widgets/banner_ad.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/model/BannersResponse.dart';
import '../api/restclient.dart';
import 'dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isLoading = false;
  var groupValue = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
    _futureData = loadData();
    loadBannersData();
    loadWallet();
  }

  //
  var scrollController = ScrollController();
  static const int PAGE_SIZE = 10;
  int start = 1;
  Future<List<OffersData>>? _futureData;

  void pagination() {
    if (isLoading) {
      return;
    }
    if ((scrollController.position.pixels ==
        scrollController.position.maxScrollExtent)) {
      setState(() {
        isLoading = true;
        start = start + 1; //+= PAGE_SIZE;
        if (_selectedIndex == 0) {
          loadData();
        } else if (_selectedIndex == 1) {
          loadMyOffersData();
        } else if (_selectedIndex == 2) {
          loadUpcomingOffers();
        }
      });
    }
  }

  //

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

  Widget buildTopOptions(String image, Color color, String title) {
    return Column(
      children: [
        // CircleAvatar(
        //   radius: 35,
        //   backgroundColor: Colors.white,
        //   child: CircleAvatar(
        //     radius: 30,
        //     backgroundColor: color,
        //     child: Image.asset(
        //       image,
        //       fit: BoxFit.contain,
        //     ),
        //   ),
        // ),
        Container(
          width: 64.w,
          height: 64.h,
          // decoration: ShapeDecoration(
          //   color: color, //Color(0xFFF0DA40),
          //   shape: RoundedRectangleBorder(
          //     side: BorderSide(width: 1, color: Color(0xFFF3F6FF)),
          //     borderRadius: BorderRadius.circular(464),
          //   ),
          // ),
          decoration: BoxDecoration(
            border: Border.fromBorderSide(
              BorderSide(
                width: 2.w,
                color: Color(0xFFF3F6FF),
              ),
            ),
            shape: BoxShape.circle, color: color, //Color(0xFFF0DA40),
          ),
          child: Image.asset(
            image,
            // fit: BoxFit.fill,
            width: 42.w,
            height: 42.h,
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Opacity(
          opacity: 0.90,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 9.sp,
              // fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.84,
            ),
          ),
        ),
        // Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double clipperHeight = 160.0;
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  // SizedBox(height: 50,),
                  Stack(
                    children: [
                      ClipPath(
                        clipper: GreenClipper(),
                        child: Container(
                          height: clipperHeight,
                          color: Color(0xff3D3FB5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                'assets/images/profile_avatar.png',
                                fit: BoxFit.cover,
                                width: 32.w,
                                // height: 200,
                                //height: 100,
                              ),
                            ),
                            Image.asset(
                              Assets.imagesHomeLogo,
                              width: 111.w,
                              height: 20.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                                // margin: EdgeInsets.all(5),2
                                color:
                                    AppColors.primaryDarkColor.withOpacity(0.5),
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
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9.sp,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 1.84,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: clipperHeight * 0.50,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigateToNext(context, TaskListPage());
                                    },
                                    child: buildTopOptions(
                                        "assets/images/img.png",
                                        Color(0xFFF0DB40),
                                        "Task"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      navigateToNext(
                                          context, ScratchCardListPage());
                                    },
                                    child: buildTopOptions(
                                        "assets/images/scratch_card_image.png",
                                        Color(0xFF70E2FE),
                                        "Scratch Card"),
                                  ),
                                  buildTopOptions(
                                      "assets/images/survey_image.png",
                                      Color(0xFFF58967),
                                      "Survey"),
                                  InkWell(
                                    onTap: () {
                                      navigateToNext(context, EarOnGamesPage());
                                      // Navigator.of(context).push(
                                      //   TutorialOverlay(
                                      //     child: ScratchCardPage(),
                                      //   ),
                                      // );
                                    },
                                    child: buildTopOptions(
                                        "assets/images/earn_on_games_image.png",
                                        Color(0xFFFF9EB7),
                                        "Earn on Games"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              // height: 300,
              //   color: Color(0xFF3D3FB5),
            ),
            SizedBox(
              height: 37.h,
            ),
            buildSegmentedControl(context),
            SizedBox(
              height: 25.h,
            ),
            // if (isLoading)
            //   Center(
            //     child: CircularProgressIndicator(
            //       strokeWidth: 1,
            //     ),
            //   ),
            // BannerAdWidget(),
            if (_selectedIndex == 0) buildAllOffers(allOffers),
            if (_selectedIndex == 1) buildAllOffers(myOffers),
            if (_selectedIndex == 2) buildAllOffers(upcomingOffers),
            buildBanners(),
          ],
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
            start = 1;
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

  Widget buildBanners() {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 133.h,
      child: PageView.builder(
        controller: PageController(initialPage: 0, viewportFraction: 0.9),
        itemCount: banners.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  launchUrlBrowser(context, banners[index].url ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      banners[index].bannerImage ?? "",
                      fit: BoxFit.fill,
                    ),
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

  HtmlEscape htmlEscape = HtmlEscape();

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url),
        mode: LaunchMode.externalApplication)) {
      // throw Exception('Could not launch $_url');
      showSnackBar(context, 'Could not launch $_url');
    }
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
            // controller: scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (isLoading && index == offersData.length) {
                return Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                ));
              }
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: getNetworkImage(
                            offersData[index].images![0].image.toString(),
                            width: 100.w,
                            height: 75.h),
                      ),
                      // Container(
                      //   width: 100.w,
                      //   height: 75.h,
                      //   decoration: ShapeDecoration(
                      //     image: DecorationImage(
                      //       image: NetworkImage(
                      //           offersData[index].images![0].image.toString()),
                      //       fit: BoxFit.cover,
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(6)),
                      //   ),
                      // ),
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
            itemCount: offersData.length + (isLoading ? 1 : 0),
          );
  }

  // List<OffersData> offersData = [];
  List<OffersData> allOffers = [];
  List<OffersData> myOffers = [];
  List<OffersData> upcomingOffers = [];
  List<BannerData> banners = [];

  Future<List<OffersData>> loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      final client = await RestClient.getRestClient();
      // var list = await client.getOffers(data.userId ?? "");
      var list =
          await client.getofferDetails(data.userId ?? "", start, PAGE_SIZE);
      //Insert add placements [START]
      var tempList = <OffersData>[];
      int count = allOffers.length;
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && count % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
        count++;
      }
      //Insert add placements [END]
      setState(() {
        // offersData = list;
        if (start == 1) {
          allOffers = tempList;
        } else {
          allOffers.addAll(tempList);
        }
      });
    } catch (e) {
      setState(() {
        if (start == 1) {
          allOffers = [];
        }
      });
    }
    setState(() {
      isLoading = false;
    });
    return allOffers;
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
      // var list = await client.getMyOffer(body);
      var list =
          await client.getMyOffersDetailspagination(start, PAGE_SIZE, body);
      //Insert add placements [START]
      int count = myOffers.length;
      var tempList = <OffersData>[];
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && count % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
        count++;
      }
      //Insert add placements [END]
      setState(() {
        if (start == 1) {
          myOffers = tempList;
        } else {
          myOffers.addAll(tempList);
        }
      });
    } catch (e) {
      setState(() {
        if (start == 1) {
          myOffers = [];
        }
      });
    }
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      var list = await client.getUpcomingofferDetails(
          data.userId.toString(), start, PAGE_SIZE);
      //Insert add placements [START]
      int count = myOffers.length;
      var tempList = <OffersData>[];
      for (int i = 0; i < list.length; i++) {
        if (i != 0 && count % 3 == 0) {
          tempList.add(OffersData(isBanner: true));
        }
        tempList.add(list[i]);
        count++;
      }
      //Insert add placements [END]
      setState(() {
        // offersData = list;
        if (start == 1) {
          upcomingOffers = tempList;
        } else {
          upcomingOffers.addAll(tempList);
        }
      });
    } catch (e) {
      setState(() {
        if (start == 1) {
          upcomingOffers = [];
        }
      });
    }
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
    } catch (e) {
      setState(() {
        banners = [];
      });
    }
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  dynamic buildItem();
}
