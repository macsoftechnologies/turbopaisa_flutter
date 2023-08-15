import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/pages/scratch_card_page.dart';
import 'package:offersapp/pages/tutorial_page.dart';

import '../utils/app_colors.dart';

class ScratchCardListPage extends StatefulWidget {
  const ScratchCardListPage({Key? key}) : super(key: key);

  @override
  State<ScratchCardListPage> createState() => _ScratchCardListPageState();
}

class _ScratchCardListPageState extends State<ScratchCardListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF3F6FF),
            child: Column(
              children: [
                Stack(children: [
                  ClipPath(
                    clipper: GreenClipper(),
                    child: Container(
                      height: 180,
                      color: Color(0xff3D3FB5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Text(
                            "Scratch card",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 85,
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: 70,
                            ),
                            Card(
                              shadowColor: Colors.white,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: DottedBorder(
                                    dashPattern: [5, 5],
                                    radius: Radius.circular(20),
                                    borderType: BorderType.RRect,

                                    // dashPattern: [
                                    //   0.5,
                                    //   1
                                    // ],
                                    color: Colors.grey,
                                    strokeWidth: 1,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/wallet_icon.png',
                                          fit: BoxFit.contain,
                                          width: 44,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          height: 46,
                                          width: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Wallet Balance",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              "₹ 5,000.00",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),

                                        // BorderRadius.only(
                                        //   topLeft: Radius.circular(50),
                                        //   topRight: Radius.circular(50),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.centerRight,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Color(0xFFE3EAFF),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹ 174",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Cashback Won",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Color(0xFFE3EAFF),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Vouchers Won",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      TutorialOverlay(
                        child: ScratchCardPage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/scratch_green.png',
                                // fit: BoxFit.fill,
                                // width: 170,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/scratch_orange.png',
                                // width: 170,
                                //width: 44,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/scratch_yellow.png',
                                //width: 44,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: Image.asset(
                                'assets/images/scratch_blue.png',
                                //fit: BoxFit.contain,
                                // width: 170,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.9),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/scratch_banner.png',
                          //width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/eog_banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/scratch_banner.png',
                          //width: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/eog_banner.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
}
