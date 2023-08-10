import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/model/RegistrationResponse.dart';
import '../api/model/UserData.dart';
import '../api/restclient.dart';
import '../utils.dart';
import 'dashboard_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _name = "";
  String _email = "";
  String _mobile = "";
  String _pincode = "";
  String _password = "";
  String _referralCode = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Registration"),
        // ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/images/turbopaisa_logo.jpeg",
                  width: 80,
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(children: [
                  Image.asset(
                    "assets/images/login_rectangle.jpeg",
                    width: 220,
                  ),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Registration",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ))),
                ]),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Type your name",
                    ),
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Type your Password",
                    ),
                    onChanged: (value) {
                      _mobile = value;
                    },
                    //decoration: InputDecoration(hintText: "Enter Phone number"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: "Type your Phone number",
                    ),

                    onChanged: (value) {
                      _email = value;
                    },
                    // decoration: InputDecoration(hintText: "Enter Email"),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextField(
                //     onChanged: (value) {
                //       _pincode = value;
                //     },
                //     decoration: InputDecoration(hintText: "Enter Pincode"),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextField(
                //     onChanged: (value) {
                //       _password = value;
                //     },
                //     obscureText: true,
                //     decoration: InputDecoration(hintText: "Enter Password"),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_sharp),
                      hintText: "Referral Code (Optional)",
                    ),
                    onChanged: (value) {
                      _referralCode = value;
                    },
                    // decoration:
                    //     InputDecoration(hintText: "Referral Code (Optional)"),
                  ),
                ),
                SizedBox(
                  height: 34,
                ),
                InkWell(
                  onTap: () {
                    submitData();
                  },
                  child: Container(
                    width: 260,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    try {
      showLoaderDialog(context);
      final client = await RestClient.getRestClient();
      Map<String, String> body = HashMap();
      body.putIfAbsent("name", () => _name);
      body.putIfAbsent("email", () => _email);
      body.putIfAbsent("mobile", () => _mobile);
      body.putIfAbsent("device_id", () => "");
      body.putIfAbsent("gaid", () => "");
      body.putIfAbsent("login_token", () => "");
      body.putIfAbsent("pincode", () => _pincode);
      body.putIfAbsent("password", () => _password);
      body.putIfAbsent("referral_id", () => _referralCode);

      RegistrationResponse data = await client.doRegister(body);
      if (data.status != 200) {
        showSnackBar(context, data.message ?? "");
        Navigator.pop(context);
      } else {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString("user", jsonEncode(data));
        Navigator.pop(context);
        Navigator.pop(context);
        showSnackBar(context, data.message ?? "");
      }
    } catch (e) {
      print(e);
      showSnackBar(context, "Invalid Details.");
      Navigator.pop(context);
    }
  }
}
