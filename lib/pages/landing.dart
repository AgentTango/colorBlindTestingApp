import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Name is : ${loginController.currentUser.value?.displayName}"),
            Text("Email is : ${loginController.currentUser.value?.email}")
          ],
        ),
      ),
    );
  }
}
