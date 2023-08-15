import 'package:flutter/material.dart';
import 'package:offersapp/utils/app_colors.dart';

class EarOnGamesPage extends StatefulWidget {
  const EarOnGamesPage({Key? key}) : super(key: key);

  @override
  State<EarOnGamesPage> createState() => _EarOnGamesPageState();
}

class _EarOnGamesPageState extends State<EarOnGamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Earn on Games"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset(
                'assets/images/eog_banner_main.png',
                fit: BoxFit.cover,
              ),
              //SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Played Games",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_knife_hit.png',
                              width: 60,
                              //fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Knife Hit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_basket_ball.png',
                              width: 60,
                              //fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Basket Ball",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_punch_heroes.png',
                              width: 60,
                              //fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Punch Heroes",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_dont_crash.png',
                              width: 60,
                              // fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Don't Crash",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Top Related Games",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_among_us.png',
                              width: 100,
                              //fit: BoxFit.fill,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text("among US")
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_sushi_roll.png',
                              width: 100,
                              // fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text("Sushi Roll 3D"),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_roof_rails.png',
                              width: 100,
                              // fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text("Roof Ralls")
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/eog_hit_master.png',
                                  width: 100,
                                  //fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text("Hit Master 3D")
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_stealth_master.png',
                              width: 100,
                              //fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text("Stealth Master")
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/images/eog_parchisi_club.png',
                              width: 100,
                              // fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text("Parchisi Club"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
            ],
          ),
        ),
      )),
    );
  }
}
