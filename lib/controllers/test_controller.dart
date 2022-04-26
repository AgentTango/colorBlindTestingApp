import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorblindtestapp/controllers/user_data_controller.dart';
import 'package:colorblindtestapp/utils/values.dart';
import 'package:get/get.dart';

class TestDataController extends GetxController {
  Map<String, String> results = {};
  showData() {
    print(results);
    print(results.length);
    print(redGreen.length);
  }

  Future<void> submitData() async {
    UserDataController userDataController = Get.find(tag: "CurrentUser");
    userDataController.userData.data = results;
    userDataController.userData.timestamp = Timestamp.now();
    final collectionRef = FirebaseFirestore.instance.collection("User Data");
    await collectionRef.add(userDataController.userData.data!);
  }
}
