import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:offersapp/pages/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/UserData.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  UserData? userData;

  Future<void> loadProfile() async {
    try {
      print("loadProfile: called");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await prefs.getString("user");
      UserData data = UserData.fromJson(jsonDecode(user!));
      setState(() {
        userData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                child: Icon(
                  Icons.person,
                  size: 25,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData?.name?.toUpperCase() ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // Text(
                  //   // "Senior Designer",
                  //   "",
                  //   style: TextStyle(fontSize: 12, color: Colors.grey),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // ElevatedButton(
                  //   style:
                  //       ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  //   onPressed: () {},
                  //   child: Text("Edit Profile"),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          // buildRow(Icons.language, "Languages"),
          // Divider(),
          buildRow(Icons.edit, "Edit Profile"),
          Divider(),
          buildRow(Icons.star_rate, "Rate Us"),
          Divider(),
          buildRow(Icons.support_agent, "Support"),
          Divider(),
          buildRow(Icons.privacy_tip, "Privacy Policy"),
          Divider(),
          buildRow(Icons.document_scanner, "Terms and Conditions"),
          Divider(),
          InkWell(
              onTap: () {
                logout();
              },
              child: buildRow(Icons.logout, "Logout")),
          Divider(),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text("Version: 1.0.0")),
          )
        ],
      ),
    );
  }

  Widget buildRow(IconData data, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            data,
            color: Colors.blue,
          ),
          SizedBox(
            width: 16,
          ),
          Text(title),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
