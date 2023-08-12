import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/api/model/OffersData.dart';
import 'package:offersapp/utils/app_colors.dart';

import '../api/model/BannersResponse.dart';
import '../api/restclient.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  var groupValue = 0;

  @override
  void initState() {
    super.initState();
    loadData();
    loadBannersData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: AppColors.appGradientBg,
      ),
      child: Column(
        children: [
          //Segment Buttons
          // buildSegmentButtons(),
          // buildBanners(),

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.yellow,
                      child: Image.asset(
                        "assets/images/img.png",
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        //height: 10,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Task", style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.cyanAccent,
                      child: Image.asset(
                        "assets/images/scratch_card_image.png",
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Scratch card",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red.withOpacity(0.8),
                      child: Image.asset(
                        "assets/images/survey_image.png",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Survey",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.pinkAccent.withOpacity(0.7),
                      child: Image.asset(
                        "assets/images/earn_on_games_image.png",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                        // height: 80,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text("Earn on Games",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.fromBorderSide(
                  BorderSide(width: 2, color: Colors.white.withOpacity(0.4)),
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 0))
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
                });
              },
            ),
          ),
          if (_selectedIndex == 0) Expanded(child: buildAllOffers()),
          if (_selectedIndex == 1) Expanded(child: buildAllOffers()),
          if (_selectedIndex == 2) Expanded(child: buildAllOffers()),
        ],
      ),
    );
  }

  Widget buildSegment(int index, String text) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.white : Colors.black,
          fontSize: _selectedIndex == index ? 14 : 12,
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

  // Widget buildBanners() {
  //   return Container(
  //     // padding: EdgeInsets.all(10),
  //     height: 160,
  //     child: PageView(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: Image.network(
  //               "https://previews.123rf.com/images/pattarasin/pattarasin1709/pattarasin170900006/85482183-sale-banner-template-design-big-sale-special-offer-end-of-season-special-offer-banner-vector.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: Image.network(
  //               "https://www.shutterstock.com/image-vector/weekend-sale-special-offer-banner-260nw-794599204.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(20),
  //             child: Image.network(
  //               "https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX47341799.jpg",
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  PageController _pageController = new PageController();

  Widget buildBanners() {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 180,
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

  HtmlEscape htmlEscape = HtmlEscape();

  Widget buildAllOffers() {
    return Column(
      children: [
        buildBanners(),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              offersData[index].images![0].image.toString(),
                              width: 120,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offersData[index].offerTitle ?? "",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  offersData[index].offerDesc ?? "",
                                  maxLines: 2,
                                ),
                                Text(
                                  "₹ ${offersData[index].offerAmount ?? ""}",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Image.asset(
                      //       "assets/images/app_logo.jpeg",
                      //       width: 80,
                      //       height: 50,
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           "Carbury Play pad",
                      //           style: TextStyle(fontWeight: FontWeight.bold),
                      //         ),
                      //         Text(
                      //           "Learn play AR",
                      //         ),
                      //         Text(
                      //           "50",
                      //           style: TextStyle(
                      //               color: Colors.purple,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 20),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    )),
              );
            },
            itemCount: offersData.length,
          ),
        ),
      ],
    );
  }

  List<OffersData> offersData = [];
  List<BannerData> banners = [];

  Future<void> loadData() async {
    try {
      final client = await RestClient.getRestClient();
      var list = await client.getOffers();
      setState(() {
        offersData = list;
      });
    } catch (e) {}
  }

  Future<void> loadBannersData() async {
    try {
      final client = await RestClient.getRestClient();
      var list = await client.getBanners();
      setState(() {
        banners = list.banner?.cast<BannerData>() ?? [];
      });
    } catch (e) {}
  }
}
