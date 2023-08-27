import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kbspinningwheel/kbspinningwheel.dart';
import 'package:offersapp/utils/app_colors.dart';

class WheelWidget extends StatefulWidget {
  @override
  State<WheelWidget> createState() => _WheelWidgetState();
}

class _WheelWidgetState extends State<WheelWidget> {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  @override
  void dispose() {
    super.dispose();
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black45,
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
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
              height: 60,
            ),
            SpinningWheel(
              image: Image.asset('assets/images/roulette-8-300.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: (event) {
                // HapticFeedback.lightImpact();
                return _dividerController.add(event);
              },
              onEnd: (event) {
                HapticFeedback.lightImpact();
                return _dividerController.add(event);
              },
              secondaryImage:
                  Image.asset('assets/images/roulette-center-300.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 30),
            StreamBuilder(
                stream: _dividerController.stream,
                builder: (context, snapshot) {
                  // if (snapshot.hasData) {
                  //   HapticFeedback.lightImpact();
                  // }
                  return snapshot.hasData
                      ? RouletteScore(snapshot.data)
                      : Container();
                }),
            SizedBox(height: 30),
            InkWell(
              onTap: (){
                HapticFeedback.lightImpact();
                _wheelNotifier.sink.add(_generateRandomVelocity());
              },
              child: Container(
                width: 260,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Click Here to Spin",
                      style: TextStyle(color: Colors.white),
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Image.asset(
                'assets/images/scratch_banner.png',
                //width: 300,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 2000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '1000\₹',
    2: '400\₹',
    3: '800\₹',
    4: '7000\₹',
    5: '5000\₹',
    6: '300\₹',
    7: '2000\₹',
    8: '100\₹',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(
            fontStyle: FontStyle.italic, fontSize: 24.0, color: Colors.white));
  }
}
