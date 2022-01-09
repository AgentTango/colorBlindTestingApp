// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:colorblindtestapp/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Image.network("${loginController.currentUser.value?.photoUrl}"),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good ${greeting()},",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "${loginController.currentUser.value?.displayName.toString()}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Test'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Exit'),
              onTap: (){
                SystemNavigator.pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Sign Out'),
              onTap: (){
                loginController.signOut();
              },
            ),
          ],
        ),
      ),
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
