import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/utils/app_colors.dart';

class WalletBalacePage extends StatefulWidget {
  const WalletBalacePage({Key? key}) : super(key: key);

  @override
  State<WalletBalacePage> createState() => _WalletBalacePageState();
}

class _WalletBalacePageState extends State<WalletBalacePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        SizedBox(height: 85,),
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
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFE3EAFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task earnings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹ 0.00",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFE3EAFF),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total withdraw",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "₹ 500.0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(
                //   color: Colors.grey.withOpacity(0.1),
                //
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(30),
                //     topRight: Radius.circular(30),
                //   ),
                // ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Transactions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // Text("Value"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    //Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        child: Icon(
                                          Icons.account_balance_wallet,
                                          color: Colors.orange,
                                        ),
                                        radius: 25,
                                        backgroundColor:
                                            Colors.orange.withOpacity(0.2),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order Id :6519",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "25 Dec 2023",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("- ₹ 500.0",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.accentColor,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Applied",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider()
                              ],
                            ),
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
