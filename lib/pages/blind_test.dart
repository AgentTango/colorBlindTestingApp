import 'dart:typed_data';

import 'package:colorblindtestapp/pages/carousel/carousel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class BlindTest extends StatefulWidget {
  const BlindTest({Key? key}) : super(key: key);

  @override
  _BlindTestState createState() => _BlindTestState();
}

class _BlindTestState extends State<BlindTest> {
  final ref = FirebaseStorage.instance.ref("test_image");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ListResult?>(
          future: ref.listAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ShowImageCarousel(snapshot.data!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}


