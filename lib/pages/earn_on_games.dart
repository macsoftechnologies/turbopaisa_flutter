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
          child: Container(
        child: Text("Games"),
      )),
    );
  }
}
