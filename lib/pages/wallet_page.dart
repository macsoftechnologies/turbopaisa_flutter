import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/api/model/WalletResponse.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/UserData.dart';

class WalletBalacePage extends StatefulWidget {
  const WalletBalacePage({Key? key}) : super(key: key);

  @override
  State<WalletBalacePage> createState() => _WalletBalacePageState();
}

class _WalletBalacePageState extends State<WalletBalacePage> {
  @override
  void initState() {
    super.initState();
    loadWallet();
  }

  bool isLoading = false;
  WalletResponse? walletResponse;

  Future<void> loadWallet() async {
    try {
      setState(() {
        isLoading = true;
      });
      final client = await RestClient.getRestClient();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));

      WalletResponse scratchCardResponse =
          await client.getTransactions(data.userId ?? "");
      setState(() {
        this.walletResponse = scratchCardResponse;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "My Wallet",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
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
                                          "₹ ${walletResponse?.wallet?.toStringAsFixed(2) ?? "0.0"}",
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
            Expanded(
              child: (isLoading)
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Color(0xFFE3EAFF),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Task earnings",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹ ${walletResponse?.taskearnings?.toStringAsFixed(2) ?? "0.0"}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Color(0xFFE3EAFF),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total withdraw",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹ ${walletResponse?.withdraw?.toStringAsFixed(2) ?? "0.0"}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                                                "Ref No:${walletResponse?.transactions![index].orderId ?? ""}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${walletResponse?.transactions![index].transactionAt ?? ""}",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  "₹ ${walletResponse?.transactions![index].transactionAmount ?? ""}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColors.accentColor,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${walletResponse?.transactions![index].transactionType ?? ""}",
                                                style: TextStyle(fontSize: 14),
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
                            itemCount:
                                walletResponse?.transactions?.length ?? 0,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
