import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class ScratchCardPage extends StatefulWidget {
  @override
  _ScratchCardPageState createState() => _ScratchCardPageState();
}

class _ScratchCardPageState extends State<ScratchCardPage> {
  ConfettiController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ConfettiController(
      duration: new Duration(seconds: 2),
    );
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
              image: Image.asset(
                "assets/images/scratch_green.png",
                fit: BoxFit.fill,
              ),
              onChange: (value) => print("Scratch progress: $value%"),
              onThreshold: () => _controller?.play(),
              child: Container(
                height: 260,
                width: 260,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/newimage.png",
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
                          numberOfParticles: 100,
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
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "₹ 150",
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
          SizedBox(
            height: 60,
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
}
