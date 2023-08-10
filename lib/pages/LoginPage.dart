import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:offersapp/api/model/UserData.dart';
import 'package:offersapp/api/restclient.dart';
import 'package:offersapp/pages/dashboard_page.dart';
import 'package:offersapp/pages/registration_page.dart';
import 'package:offersapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "";
  String _password = "";
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            //color: Colors.lightBlueAccent.withOpacity(0.2),
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
                    width: 250,
                  ),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "Welcome Back",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text("Login to continue")
                            ],
                          ))),
                ]),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Username",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
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
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Password",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Type your Password",
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                        //decoration: InputDecoration(hintText: "Enter Phone number"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text("Forgot Password?"),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 34,
                ),
                InkWell(
                  onTap: () {
                    submitData();
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/coin.png",
                        // width: 80,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(""),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/images/coin_two.png",
                      //width: 80,
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => RegistrationPage(),
                        ));
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/facebook_logo.png',
                          fit: BoxFit.cover,
                          width: 30,
                          //height: 40,
                        ),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/instagram_logo.png',
                          fit: BoxFit.cover,
                          width: 26,
                        ),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.8),
                        child: Image.asset(
                          'assets/images/youtube_logo.png',
                          fit: BoxFit.cover,
                          width: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                // Image.asset(
                //   "assets/images/rectangle .png",
                //   //width: 80,
                // ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Center(
        //   child: Text(
        //     "Login",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        //   ),
        // ),
        // SizedBox(
        //   height: 30,
        // ),
        // Image.asset(
        //   "assets/images/app_logo.jpeg",
        //   width: 80,
        // ),
        // SizedBox(
        //   height: 30,
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextField(
        //     onChanged: (value) {
        //       _email = value;
        //     },
        //     decoration: InputDecoration(hintText: "Enter Email"),
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
        // SizedBox(
        //   height: 20,
        // ),
        // InkWell(
        //   onTap: () {
        //     submitData();
        //   },
        //   child: Container(
        //     width: 200,
        //     padding: EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       color: Colors.blue,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Center(
        //       child: Text(
        //         "Sign In",
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Future<void> submitData() async {
    try {
      showLoaderDialog(context);
      final client = await RestClient.getRestClient();
      Map<String, String> body = HashMap();
      body.putIfAbsent("email", () => _email);
      body.putIfAbsent("password", () => _password);

      UserData data = await client.doLogin(body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user", jsonEncode(data));

      Navigator.pop(context);
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
    } catch (e) {
      showSnackBar(context, "Invalid Login Details.");
      Navigator.pop(context);
    }
  }
}
