import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/api/model/OffersData.dart';
import 'package:offersapp/utils/app_colors.dart';

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

  List<OffersData> offersData = [];
  List<BannerData> banners = [];

  @override
  void initState() {
    super.initState();
    loadData();
    loadBannersData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final client = await RestClient.getRestClient();
      var list = await client.getOffers();
      setState(() {
        offersData = list;
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Task"),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
              child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
            )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    buildSegmentedControl(context),
                    if (_selectedIndex == 0) buildAllOffers(),
                    if (_selectedIndex == 1) buildAllOffers(),
                    if (_selectedIndex == 2) buildAllOffers(),
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

  Widget buildAllOffers() {
    return ListView.builder(
      key: UniqueKey(),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              shadowColor: Colors.white,
              elevation: 2,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "₹ ${offersData[index].offerAmount ?? ""}",
                            style: TextStyle(
                                color: Colors.red,
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
    );
  }

  PageController _pageController =
      new PageController(initialPage: 0, viewportFraction: 0.8);

  Widget buildBanners() {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 150,
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
}
