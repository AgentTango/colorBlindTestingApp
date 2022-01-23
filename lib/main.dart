// ignore_for_file: prefer_const_constructors

import 'package:colorblindtestapp/models/test_data_model.dart';
import 'package:colorblindtestapp/pages/blind_test.dart';
import 'package:colorblindtestapp/pages/landing_page.dart';
import 'package:colorblindtestapp/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
              .copyWith(primary: Colors.black, onPrimary: Colors.white)),
      home: Obx(() {
        loginController.initializeController();
        if (loginController.currentUser.value == null) {
          return WelcomePage();
        } else {
          return LandingPage();
        }
      }),
    );
  }
}
