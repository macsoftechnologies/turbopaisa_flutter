import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Scratch Card"),
      ),
      body: SafeArea(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                TutorialOverlay(
                  child: ScratchCardPage(),
                ),
              );
            },
            child: Text("Click"),
          ),
        ),
      ),
    );
  }
}
