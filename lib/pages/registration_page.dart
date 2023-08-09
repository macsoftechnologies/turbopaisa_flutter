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
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/images/app_logo.jpeg",
                width: 80,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _name = value;
                  },
                  decoration: InputDecoration(hintText: "Enter Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _mobile = value;
                  },
                  decoration: InputDecoration(hintText: "Enter Phone number"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _email = value;
                  },
                  decoration: InputDecoration(hintText: "Enter Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _pincode = value;
                  },
                  decoration: InputDecoration(hintText: "Enter Pincode"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Enter Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _referralCode = value;
                  },
                  decoration:
                      InputDecoration(hintText: "Referral Code (Optional)"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  submitData();
                },
                child: Container(
                  width: 200,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
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
