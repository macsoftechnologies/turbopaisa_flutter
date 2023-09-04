import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/BannersResponse.dart';
import 'package:offersapp/api/model/ScratchCardResponse.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/pages/scratch_card_page.dart';
import 'package:offersapp/pages/tutorial_page.dart';
import 'package:offersapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_colors.dart';

class ScratchCardListPage extends StatefulWidget {
  const ScratchCardListPage({Key? key}) : super(key: key);

  @override
  State<ScratchCardListPage> createState() => _ScratchCardListPageState();
}

class _ScratchCardListPageState extends State<ScratchCardListPage> {
  @override
  void initState() {
    super.initState();
    loadScratchCards();
    loadBannersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF3F6FF),
          // height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(children: [
                  ClipPath(
                    clipper: GreenClipper(),
                    child: Container(
                      height: 170.h,
                      color: Color(0xff3D3FB5),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.h, horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Text(
                        "Scratch card",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70.h,
                    left: 77.w,
                    right: 77.w,
                    child: Container(
                      width: 218.83.w,
                      height: 95.14.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.w),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x2D000000),
                            blurRadius: 26.16,
                            offset: Offset(6.34, 3.17),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(7.5.w),
                        child: DottedBorder(
                          // dashPattern: [5, 5],
                          radius: Radius.circular(20),
                          borderType: BorderType.RRect,
                          dashPattern: [1, 2],
                          color: Colors.grey,
                          strokeWidth: 1,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 13.w,
                              ),
                              Image.asset(
                                'assets/images/wallet_icon.png',
                                // fit: BoxFit.contain,
                                width: 35.w,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                // margin: EdgeInsets.all(10),
                                height: 46,
                                width: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 23.h,
                                  ),
                                  Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.69,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      height: 1.04,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    "₹ ${scratchCardResponse?.wallet?.toStringAsFixed(2) ?? "0.0"}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.86,
                                      // fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      height: 0.83,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 96.h,
                    right: 74.w,
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Image.asset(
                          'assets/images/semirectangle.png',
                          width: 44,
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            'assets/images/white_circle.png',
                            width: 3,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 140.w,
                      height: 53.h,
                      // padding:
                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.fromBorderSide(
                            BorderSide(color: Color(0xFFD6E0FF), width: 1),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "₹ ${scratchCardResponse?.moneywon?.toStringAsFixed(2) ?? "0.00"}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.19,
                            ),
                          ),
                          Text(
                            "Money Won",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.84,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      width: 140.w,
                      height: 53.h,
                      // padding:
                      //     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Color(0xFFED3E55),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${scratchCardResponse?.scratchcardwon ?? "0"}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.19,
                            ),
                          ),
                          Text(
                            'Scratch Cards Won',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              height: 1.84,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                if (!isLoading && scratchCardResponse?.cards?.length == 0)
                  Container(
                    constraints: BoxConstraints(minHeight: 200),
                    child: Center(child: Text("No Scatchcards Available.")),
                  ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 14.h),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: scratchCardResponse?.cards?.length ?? 0,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20.w,
                                  mainAxisExtent: 210.h,
                                  mainAxisSpacing: 20.h),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (scratchCardResponse!
                                        .cards![index].scratchStatus !=
                                    0) {
                                  return;
                                }
                                Navigator.of(context)
                                    .push(
                                      TutorialOverlay(
                                        child: ScratchCardPage(
                                            data: scratchCardResponse!
                                                .cards![index]),
                                      ),
                                    )
                                    .whenComplete(() => loadScratchCards());
                              },
                              child: Container(
                                child: scratchCardResponse!
                                            .cards![index].scratchStatus ==
                                        0
                                    ? buildCard(index)
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Image.asset(
                                            //   "assets/images/scratch_card_cup.png",
                                            //   fit: BoxFit.contain,
                                            //   width: 120,
                                            //   height: 120,
                                            // ),
                                            getNetworkImage(
                                              scratchCardResponse!.cards![index]
                                                      .scratchImage ??
                                                  "",
                                              fit: BoxFit.contain,
                                              width: 80.w,
                                              height: 80.h,
                                            ),
                                            // Image.network(
                                            //   scratchCardResponse!
                                            //           .cards![index]
                                            //           .scratchImage ??
                                            //       "",
                                            //   width: 80.w,
                                            //   height: 80.h,
                                            // ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            if (scratchCardResponse!
                                                    .cards![index].type ==
                                                "Cashback")
                                              ...buildCashback(
                                                  scratchCardResponse!
                                                      .cards![index]),
                                            if (scratchCardResponse!
                                                    .cards![index].type ==
                                                "Vocher/Discount")
                                              ...buildClaimNow(
                                                  scratchCardResponse!
                                                      .cards![index])
                                          ],
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                Container(
                  width: 336.w,
                  height: 38.h,
                  padding:
                      EdgeInsets.symmetric(vertical: 11.h, horizontal: 17.w),
                  decoration: ShapeDecoration(
                    color: Color(0xFFF1F4FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.25, color: Color(0xFF8BB6FF)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Row(
                    children: [
                      buildIndicators(Color(0xFF32A951), "Money Reward"),
                      buildIndicators(Color(0xFFFA9623), "Vouchers"),
                      buildIndicators(Color(0xFF3F87FF), "Cash Back"),
                      buildIndicators(Color(0xFFFAE103), "Discounts"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                buildBanners(),
              ],
              // onPressed: () {
              //   Navigator.of(context).push(
              //     TutorialOverlay(
              //       child: ScratchCardPage(),
              //     ),
              //   );
              // },
              // child: Text("Click"),
            ),
          ),
        ),
      ),
    );
  }

  ScratchCardResponse? scratchCardResponse;
  bool isLoading = false;

  Future<void> loadScratchCards() async {
    try {
      setState(() {
        this.scratchCardResponse = null;
        isLoading = true;
      });
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      ScratchCardResponse scratchCardResponse =
          await client.getScratchcards(data.userId ?? "");
      // await client.getScratchcards("1");
      setState(() {
        this.scratchCardResponse = scratchCardResponse;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        scratchCardResponse = null;
        isLoading = false;
      });
    }
  }

  Widget buildCard(int index) {
    if (scratchCardResponse?.cards![index].scratchColor == "Green") {
      return Image.asset(
        'assets/images/scratch_green.png',
      );
    } else if (scratchCardResponse?.cards![index].scratchColor == "Yellow") {
      return Image.asset(
        'assets/images/scratch_yellow.png',
      );
    } else if (scratchCardResponse?.cards![index].scratchColor == "Orange") {
      return Image.asset(
        'assets/images/scratch_orange.png',
      );
    } else if (scratchCardResponse?.cards![index].scratchColor == "Blue") {
      return Image.asset(
        'assets/images/scratch_blue.png',
      );
    }
    return SizedBox();
  }

  String getDesc(ScratchCards cards) {
    if (cards.yellowDesc?.isEmpty == false) {
      return cards.yellowDesc ?? "";
    } else if (cards.blueDesc?.isEmpty == false) {
      return cards.blueDesc ?? "";
    }
    return cards.orangeDesc ?? "";
  }

  List<Widget> buildClaimNow(ScratchCards data) {
    return [
      Text(
        "₹ ${data.scratchAmount}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.71,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 1.19,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${getDesc(data)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF170F49),
            fontSize: 12,
            // fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 1.46,
          ),
        ),
      ),
      // SizedBox(
      //   height: 13.h,
      // ),
      InkWell(
        onTap: () {
          if (data.url != null && data.url!.isNotEmpty) {
            launchUrlBrowser(context, data.url ?? "");
          }
        },
        child: Container(
          width: 132.w,
          height: 25.h,
          // padding: const EdgeInsets.symmetric(horizontal: 36.16, vertical: 20.26),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFED3E55),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: [
              BoxShadow(
                color: Color(0x3A4A3AFF),
                blurRadius: 17.08,
                offset: Offset(0, 9.69),
                spreadRadius: 0,
              )
            ],
          ),
          child: Center(
            child: Text(
              'Claim Now',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                // fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 2,
              ),
            ),
          ),
        ),
      )
    ];
  }

  List<Widget> buildCashback(ScratchCards data) {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${getDesc(data)}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF170F49),
            fontSize: 12,
            // fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 1.46,
          ),
        ),
      ),
      Text(
        "₹ ${data.scratchAmount}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 24.71,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          height: 1.19,
        ),
      ),
    ];
  }

  Widget buildIndicators(Color materialColor, String s) {
    return Row(
      children: [
        Container(
          width: 15.94,
          height: 15.94,
          decoration: ShapeDecoration(
            color: materialColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1.59),
            ),
          ),
        ),
        SizedBox(
          width: 5.5.w,
        ),
        Text(
          s,
          style: TextStyle(
            color: Colors.black,
            fontSize: 7.17,
            // fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.52,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
      ],
    );
  }

  List<BannerData> banners = [];

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: getNetworkImage(
                      banners[index].bannerImage ?? "",
                    )

                    // Image.network(
                    //   banners[index].bannerImage ?? "",
                    //   fit: BoxFit.cover,
                    // ),
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

  Future<void> loadBannersData() async {
    try {
      final client = await RestClient.getRestClient();
      var list = await client.getBanners("home");
      setState(() {
        banners = list.banner?.cast<BannerData>() ?? [];
      });
    } catch (e) {}
  }
}
// Future<void> _launchUrl(BuildContext context, String _url) async {
//   if (!await launchUrl(Uri.parse(_url),
//       mode: LaunchMode.externalApplication)) {
//     // throw Exception('Could not launch $_url');
//     showSnackBar(context, 'Could not launch $_url');
//   }
// }
