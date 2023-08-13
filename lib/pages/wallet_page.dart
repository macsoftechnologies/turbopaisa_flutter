import 'package:flutter/material.dart';
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
            SizedBox(
              height: 20,
            ),
            Text("Balance"),
            Text(
              "27,350/-",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
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
                    children: [
                      Text("Task earnings"),
                      Text(
                        "0/-",
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
                    children: [
                      Text("Total withdraw"),
                      Text(
                        "0/-",
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
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recent Transactions"),
                          // Text("Value"),
                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Icons.wallet,
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
                                        SizedBox(height: 10,),
                                        Text(
                                          "25 Dec 2023",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("- 4,400/-",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.accentColor,
                                                fontWeight: FontWeight.bold)),

                                        SizedBox(height: 10,),
                                        Text("Applied"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
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

