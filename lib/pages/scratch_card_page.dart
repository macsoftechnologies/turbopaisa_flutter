import 'dart:collection';
import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:offersapp/api/model/RegistrationResponse.dart';
import 'package:offersapp/api/model/ScratchCardResponse.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:scratcher/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/UserData.dart';

class ScratchCardPage extends StatefulWidget {
  final ScratchCards data;

  ScratchCardPage({Key? key, required this.data}) : super(key: key);

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
              onChange: (value) => print("Scratch progress: $value%"),
              onThreshold: () {
                _controller?.play();
                setState(() {
                  isCongratulations = true;
                });
                updateToServer();
              },
              child: Container(
                height: 260,
                width: 260,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/scratch_card_cup.png",
                      fit: BoxFit.contain,
                      width: 120,
                      height: 120,
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
                        Text(
                          "Cashback Won",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          "₹ ${widget.data.scratchAmount}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                          ),
                        ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Image.asset(
              'assets/images/scratch_banner.png',
              //width: 300,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Image.asset(
              'assets/images/eog_banner.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
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
}
