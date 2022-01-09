// ignore_for_file: prefer_const_constructors

import 'package:colorblindtestapp/pages/landing.dart';
import 'package:colorblindtestapp/pages/welcome_page.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx((){
        loginController.initializeController();
        if(loginController.currentUser.value == null){
          return WelcomePage();
        }
        else {
          return LandingPage();
        }
      }),
    );
  }
}


