// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:colorblindtestapp/controllers/login_controller.dart';
import 'package:colorblindtestapp/pages/about_page.dart';
import 'package:colorblindtestapp/pages/blind_test.dart';
import 'package:colorblindtestapp/pages/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:colorblindtestapp/misc/greeting.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 16),
          Text(
            "Welcome to Chroma",
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(height: 16),
          Text(
            "Here we will test for different types of color blindness using this App. Make sure of the following : ",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Container(height: 16),
          Text(
            "1. Your phone should be at full brightness.\n2. There should be ample amount of natural light.\n3. Make sure there is enough battery.\n4. And, lastly, that you are connected to the internet throughout the test.",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(height: 16),
          RichText(
            text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 16),
                children: [
                  TextSpan(text: "You will be allowed to take the test "),
                  TextSpan(
                      text: "once",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  TextSpan(text: ", after which the results will be displayed.")
                ]),
          ),
          Container(height: 24),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext buildContext) => TestPage()));
              },
              child: Text("Start Test"))
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: Text("Chroma"),
      centerTitle: true,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  child: Image.network(
                      "${loginController.currentUser.value?.photoUrl}"),
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
            title: Text('About Chroma'),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (BuildContext context) => AboutPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text('Exit'),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Sign Out'),
            onTap: () {
              loginController.signOut();
            },
          ),
        ],
      ),
    );
  }
}
