import 'dart:collection';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:offersapp/api/model/BannersResponse.dart';
import 'package:offersapp/api/model/RegistrationResponse.dart';
import 'package:offersapp/api/model/ScratchCardResponse.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/utils.dart';
import 'package:scratcher/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/model/UserData.dart';

class ScratchCardPage extends StatefulWidget {
  final ScratchCards data;
  List<BannerData> banners = [];

  ScratchCardPage({Key? key, required this.data, required this.banners})
      : super(key: key);

  @override
  _ScratchCardPageState createState() => _ScratchCardPageState();
}

class _ScratchCardPageState extends State<ScratchCardPage> {
  ConfettiController? _controller;
  bool isCongratulations = false;

  @override
  void initState() {
    super.initState();
    _controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
  }

  Image? buildCard(ScratchCards card) {
    if (card.scratchColor == "Green") {
      return Image.asset(
        'assets/images/scratch_green.png',
      );
    } else if (card.scratchColor == "Yellow") {
      return Image.asset(
        'assets/images/scratch_yellow.png',
      );
    } else if (card.scratchColor == "Orange") {
      return Image.asset(
        'assets/images/scratch_orange.png',
      );
    } else if (card.scratchColor == "Blue") {
      return Image.asset(
        'assets/images/scratch_blue.png',
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: Scratcher(
              brushSize: 50,
              threshold: 75,
              color: Colors.grey,
              image: buildCard(widget.data),

              // Image.asset(
              //   "assets/images/scratch_green.png",
              //   fit: BoxFit.fill,
              // ),
              // onChange: (value) => print("Scratch progress: $value%"),
              onThreshold: () {
                _controller?.play();
                setState(() {
                  isCongratulations = true;
                });
                updateToServer();
              },
              child: Container(
                height: 260.w,
                width: 260.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   "assets/images/scratch_card_cup.png",
                    //   fit: BoxFit.contain,
                    //   width: 120,
                    //   height: 120,
                    // ),
                    // getNetworkImage(
                    //   widget.data.scratchImage ?? "",
                    //   fit: BoxFit.contain,
                    //   placeholder: "assets/images/scratch_card_cup.png",
                    //   width: 135.w,
                    //   height: 95.h,
                    // ),
                    Image.network(
                      widget.data.scratchImage ?? "",
                      width: 135.w,
                      height: 95.h,
                    ),
                    Column(
                      children: [
                        ConfettiWidget(
                          blastDirectionality: BlastDirectionality.explosive,
                          confettiController: _controller!,
                          particleDrag: 0.05,
                          emissionFrequency: 0.05,
                          numberOfParticles: 50,
                          gravity: 0.05,
                          shouldLoop: false,
                          colors: [
                            Colors.green,
                            Colors.red,
                            Colors.yellow,
                            Colors.blue,
                          ],
                        ),
                        if (widget.data.type == "Cashback") ...buildCashback(),
                        if (widget.data.type == "Vocher/Discount")
                          ...buildClaimNow(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isCongratulations)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Congratulations 🎉",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          SizedBox(
            height: 30,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 26),
          //   child: Image.asset(
          //     'assets/images/scratch_banner.png',
          //     //width: 300,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 26),
          //   child: Image.asset(
          //     'assets/images/eog_banner.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          buildBanners(),
        ],
      ),
    );
  }

  Widget buildBanners() {
    return Container(
      // padding: EdgeInsets.all(10),
      height: 133.h,
      child: PageView.builder(
        controller: PageController(initialPage: 0, viewportFraction: 0.9),
        itemCount: widget.banners.length,
        itemBuilder: (context, index) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  launchUrlBrowser(context, widget.banners[index].url ?? "");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: getNetworkImage(
                        widget.banners[index].bannerImage ?? "",
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateToServer() async {
    //scratchcardUserinsert
    try {
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      Map<String, String> body = HashMap();
      body.putIfAbsent("user_id", () => data.userId.toString());
      body.putIfAbsent("scratch_id", () => widget.data.scratchId ?? "");
      body.putIfAbsent("amount", () => widget.data.scratchAmount ?? "");

      RegistrationResponse response = await client.scratchcardUserinsert(body);
      if (response.status == 200) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      print(e);
    }
  }

  String getDesc() {
    if (widget.data.type == "Cashback") {
      return widget.data.yellowDesc ?? "";
    } else if (widget.data.blueDesc?.isEmpty == false) {
      return widget.data.blueDesc ?? "";
    }
    return widget.data.orangeDesc ?? "";
  }

  List<Widget> buildClaimNow() {
    return [
      Text(
        "₹ ${widget.data.scratchAmount}",
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
          "${getDesc()}",
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
      SizedBox(
        height: 13.h,
      ),
      InkWell(
        onTap: () {
          if (widget.data.url != null && widget.data.url!.isNotEmpty) {
            launchUrlBrowser(context, widget.data.url ?? "");
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

  List<Widget> buildCashback() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${getDesc()}",
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
        "₹ ${widget.data.scratchAmount}",
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
}
