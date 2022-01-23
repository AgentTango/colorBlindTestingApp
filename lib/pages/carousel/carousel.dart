import 'package:colorblindtestapp/controllers/test_controller.dart';

import 'package:colorblindtestapp/pages/carousel/show_image_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowImageCarousel extends StatefulWidget {
  final ListResult listResult;
  const ShowImageCarousel(this.listResult);

  @override
  State<ShowImageCarousel> createState() => _ShowImageCarouselState();
}

class _ShowImageCarouselState extends State<ShowImageCarousel> {
  var page_index = 0.obs;
  final PageController controller =
      PageController(initialPage: 0, keepPage: true);

  TestDataController testDataController = Get.put(TestDataController());
  @override
  Widget build(BuildContext context) {
    final maxLength = widget.listResult.items.length;
    return SafeArea(
      child: Scaffold(
          bottomSheet: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      controller.jumpToPage(index,
                        );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                        color: page_index.value == index
                            ? Colors.redAccent
                            : Colors.transparent,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: page_index.value == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              itemCount: maxLength,
            ),
          ),
          body: PageView.builder(
            controller: controller
              ..addListener(() {
                page_index.value = controller.page!.toInt();
              }),
            itemCount: maxLength,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.listResult.items[index];
              return ShowImageCard(item, controller, testDataController,maxLength);
            },
          )),
    );
  }
}
