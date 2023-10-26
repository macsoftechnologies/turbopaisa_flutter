import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kbspinningwheel/kbspinningwheel.dart';
import 'package:offersapp/api/model/RegistrationResponse.dart';
import 'package:offersapp/api/model/SpinWheelResponse.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/utils.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:offersapp/widgets/spinning_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api/model/BannersResponse.dart';
import '../api/model/ScratchCardResponse.dart';

class WheelWidget extends StatefulWidget {
  SpinWheelResponse data;

  WheelWidget({Key? key, required this.data});

  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget> {
  final Map<int, String> labels = {
    // 1: '1000\₹',
    // 2: '400\₹',
    // 3: '800\₹',
    // 4: '7000\₹',
    // 5: '5000\₹',
    // 6: '300\₹',
    // 7: '2000\₹',
    // 8: '100\₹',
  };
  bool isCongratulations = false;
  bool isEnable = false;
  SpinController _spinController = SpinController();

  Image? bgImage;
  List<BannerData> banners = [];

  //bgImage = new Image.memory(await http.readBytes(imageUrl));
  @override
  void initState() {
    super.initState();
    int count = 1;
    widget.data.spinlist?.forEach((element) {
      labels.putIfAbsent(count++, () => "${element.amount}\₹");
    });
    loadImage();
    loadBannersData();
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

  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  bool isWheel = false;

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              height: 120.h,
            ),
            if (!isCongratulations)
              bgImage == null
                  ? SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                      ),
                    )
                  : SpinningWheelWidget(
                      sectors: widget.data.spinlist?.reversed.toList() ?? [],
                      width: 300,
                      height: 300,
                      image: bgImage!,
                      // Image.network(
                      //   widget.data.spinImage ?? "",
                      // ),
                      selectedIndex: findIndex(
                          widget.data.spinlist?.reversed.toList(),
                          widget.data.spinAmount),
                      onEnd: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          isCongratulations = true;
                        });
                        updateToServer();
                      },
                      controller: _spinController,
                    ),
            // buildOldSpin(),
            // SizedBox(height: 30),
            // StreamBuilder(
            //     stream: _dividerController.stream,
            //     builder: (context, snapshot) {
            //       return isWheel && snapshot.hasData
            //           ? RouletteScore(labels, snapshot.data)
            //           : Container();
            //     }),

            if (isCongratulations) buildClaimNow(widget.data),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 16.0),
            //   child: Text(
            //     "Congratulations 🎉",
            //     style: TextStyle(color: Colors.white, fontSize: 18),
            //   ),
            // ),
            SizedBox(height: 10),
            if (!isCongratulations)
              InkWell(
                onTap: !isEnable
                    ? null
                    : () {
                        HapticFeedback.lightImpact();
                        // _wheelNotifier.sink.add(_generateRandomVelocity());
                        setState(() {
                          isWheel = true;
                          isEnable = false;
                        });
                        _spinController.setValue(true);
                      },
                child: Container(
                  width: 250.w,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isEnable ? AppColors.accentColor : Color(0xFF424242),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Click Here to Spin",
                        style: TextStyle(
                          color: isEnable ? Colors.white : Color(0xFF858585),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            // new ElevatedButton(
            //     // child: new Text(
            //     //   "Click Here to Spin",
            //     //   style: TextStyle(color: Color(0xFF858585)),
            //     // ),
            //     // style: ElevatedButton.styleFrom(
            //     //   backgroundColor: Color(0xFF464646),
            //     // ),
            //     child: new Text(
            //       "Click Here to Spin",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF464646),
            //       minimumSize: Size(250, 40),
            //     ),
            //     onPressed: () {
            //       HapticFeedback.lightImpact();
            //       _wheelNotifier.sink.add(_generateRandomVelocity());
            //     }),
            SizedBox(
              height: 40.h,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 26),
            //   child: Image.asset(
            //     'assets/images/scratch_banner.png',
            //     //width: 300,
            //     fit: BoxFit.cover,
            //   ),
            // ),

            buildBanners(),
          ],
        ),
      ),
    );
  }

  Widget buildClaimNow(SpinWheelResponse data) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getNetworkImage(
              data.spin_add_image ?? "",
              fit: BoxFit.contain,
              width: 100.w,
              height: 80.h,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // "${getDesc(data)}",
                  "${data.spinDesc}",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    color: Color(0xFF170F49),
                    fontSize: 12,
                    // fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.46,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (data.url != null && data.url!.isNotEmpty) {
                    launchUrlBrowser(context, data.url ?? "");
                    Navigator.pop(context, true);
                  }
                },
                child: Container(
                  width: 132.w,
                  height: 25.h,
                  // padding: const EdgeInsets.symmetric(horizontal: 36.16, vertical: 20.26),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFED3E55),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
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
                      data.btn_text ?? 'Claim Now',
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
            ],
          ),
          // SizedBox(
          //   height: 13.h,
          // ),
          Spacer(),
          InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(Icons.close)),
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
                      fit: BoxFit.cover,
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

  // AbsorbPointer buildOldSpin() {
  //   return AbsorbPointer(
  //     child: SpinningWheel(
  //       // image: Image.asset('assets/images/roulette-8-300.png'),
  //       image: Image.network(
  //         widget.data.spinImage ?? "",
  //         //   loadingBuilder:  (context, child, loadingProgress) {
  //         //   print(loadingProgress);
  //         //   return Text("");
  //         // },
  //       ),
  //       width: 310,
  //       height: 310,
  //       initialSpinAngle: _generateRandomAngle(),
  //       spinResistance: 0.6,
  //       canInteractWhileSpinning: false,
  //       dividers: widget.data.spinlist?.length ?? 0,
  //       onUpdate: (event) {
  //         // print(labels[event+1]);
  //         // HapticFeedback.lightImpact();
  //         return _dividerController.add(event + 1);
  //       },
  //       onEnd: (event) {
  //         HapticFeedback.lightImpact();
  //         // print(event+1);
  //         print(labels[event + 1]);
  //
  //         setState(() {
  //           isCongratulations = true;
  //         });
  //         updateToServer();
  //         return _dividerController.add(event + 1);
  //       },
  //       secondaryImage: Image.asset('assets/images/roulette-center-300.png'),
  //       secondaryImageHeight: 110,
  //       secondaryImageWidth: 110,
  //       shouldStartOrStop: _wheelNotifier.stream,
  //     ),
  //   );
  // }
  //
  // // double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  // double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;
  //
  // double _generateRandomAngle() => Random().nextDouble() * pi * 2;

  Future<void> updateToServer() async {
    //scratchcardUserinsert
    try {
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      Map<String, String> body = HashMap();
      body.putIfAbsent("user_id", () => data.userId.toString());
      body.putIfAbsent("spin_id", () => widget.data.spinId ?? "");
      body.putIfAbsent("amount", () => widget.data.spinAmount ?? "");
      RegistrationResponse response = await client.spinUserinsert(body);
      if (response.status == 200) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      print(e);
    }
  }

  findIndex(List<Spinlist>? list, String? spinAmount) {
    return list?.indexWhere((element) => element.amount == spinAmount);
  }

  Future<void> loadImage() async {
    var bgImage = Image.memory(
      await http.readBytes(
        Uri.parse(widget.data.spinImage ?? ""),
      ),
    );
    setState(() {
      this.bgImage = bgImage;
      isEnable = widget.data.spin_status == 0;
    });
  }
}

class RouletteScore extends StatelessWidget {
  final int selected;
  Map<int, String> labels;

  RouletteScore(this.labels, this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(
            fontStyle: FontStyle.italic, fontSize: 24.0, color: Colors.white));
  }
}
