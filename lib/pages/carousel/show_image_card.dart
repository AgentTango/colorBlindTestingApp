// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';

import 'package:colorblindtestapp/controllers/test_controller.dart';
import 'package:colorblindtestapp/models/test_data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ShowImageCard extends StatefulWidget {
  final Reference item;
  final maxLength;
  final PageController pageController;
  final TestDataController testDataController;

  const ShowImageCard(
      this.item, this.pageController, this.testDataController, this.maxLength,
      {Key? key})
      : super(key: key);

  @override
  _ShowImageDetailState createState() => _ShowImageDetailState();
}

class _ShowImageDetailState extends State<ShowImageCard> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<Uint8List?>(
      stream: widget.item.getData(1 * 1024 * 1024).asStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final bool isFirstPage =
              widget.pageController.page == widget.pageController.initialPage;
          final bool isLastPage =
              widget.pageController.page == widget.maxLength - 1;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Image.memory(
                  snapshot.data!,
                ),
                GetBuilder<TestDataController>(builder: (context) {
                  if (widget.testDataController.results[widget.item.name] !=
                      null) {
                    textEditingController.text =
                        widget.testDataController.results[widget.item.name]!;
                  }
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 36, bottom: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    child: TextField(
                      onTap: () {
                        if (textEditingController.text == "NaN") {
                          textEditingController.clear();
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: textEditingController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 16, bottom: 8, top: 8, right: 16),
                          hintText: "Number"),
                    ),
                  );
                }),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   // ignore: sized_box_for_whitespace
                //   child: Container(
                //     width: 204,
                //     height: 40,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         if (textEditingController.text.isNotEmpty) {
                //           widget.testDataController.results[widget.item.name] =
                //               textEditingController.text;
                //           Get.snackbar("Saved", "Number is Saved",
                //               duration: Duration(milliseconds: 1200),
                //               backgroundColor: Colors.white,
                //               snackPosition: SnackPosition.BOTTOM);
                //         }
                //       },
                //       child: const Text("Save"),
                //       style: ElevatedButton.styleFrom(primary: Colors.green),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    width: 204,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        textEditingController.text = "NaN";
                        widget.testDataController.results[widget.item.name] =
                            textEditingController.text;
                        widget.pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      child: const Text("Not a Number"),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(36),
                      child: FloatingActionButton.extended(
                        onPressed: isFirstPage
                            ? null
                            : () {
                                widget.pageController.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut);
                              },
                        heroTag: const Text('Back'),
                        label: const Text("Back"),
                        backgroundColor: isFirstPage
                            ? Colors.blueGrey.shade100
                            : Colors.blueGrey,
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.all(36),
                      child: FloatingActionButton.extended(
                        onPressed: isLastPage
                            ? () {
                                widget.testDataController.showData();
                                if (textEditingController.text.isNotEmpty) {
                                  widget.testDataController
                                          .results[widget.item.name] =
                                      textEditingController.text;
                                  Get.snackbar("Saved", "All Inputs are Saved",
                                      duration: Duration(milliseconds: 1200),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.green,
                                      icon: Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM);
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text("Submit This Data?"),
                                      //content: const Text("You can't go back"),
                                      actions: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              side: BorderSide(width: 1.5)),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              submitData();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: const Text("Save"),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Get.snackbar("Error", "Please enter a number",
                                      duration: Duration(milliseconds: 1200),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.red,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              }
                            : () {
                                if (textEditingController.text.isNotEmpty) {
                                  widget.testDataController
                                          .results[widget.item.name] =
                                      textEditingController.text;
                                  Get.snackbar("Saved", "Input was Saved",
                                      duration: Duration(milliseconds: 1200),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.green,
                                      icon: Icon(
                                        Icons.check_box,
                                        color: Colors.green,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM);
                                  widget.pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut);
                                } else {
                                  Get.snackbar("Error", "Please enter a number",
                                      duration: Duration(milliseconds: 1200),
                                      backgroundColor: Colors.white,
                                      colorText: Colors.red,
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                        heroTag: const Text("Next"),
                        label: isLastPage ? Text("Submit") : Text("Next"),
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    ));
  }

  Future<void> submitData() async {
    await widget.testDataController.submitData();
    Get.back();
  }
}
