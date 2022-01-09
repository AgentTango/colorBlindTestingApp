// ignore_for_file: prefer_const_constructors

import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:colorblindtestapp/pages/landing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(loginController.currentUser.value!=null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>LandingPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Color.fromARGB(190, 0, 0, 0)])),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Welcome\nto the"
                          "\nColor Blind\nTesting App.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 56.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
                    )
                  ],
                ),
              ),
            ),
            flex: 10,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 56.0,
              decoration: const BoxDecoration(color: Colors.white),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    loginController.signIn();
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  splashFactory: InkRipple.splashFactory,
                  onPrimary: Colors.black,
                ),
                child: const Text(
                  "Log In with Google",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

