import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {
  String name;
  int age;
  String password;
  late Timestamp timestamp;
  String phone;
  Map<String, String>? data;
  toJson() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'data': data,
    };
  }

  UserData(
      {required this.name,
      required this.age,
      this.data,
      required this.password,
      required this.phone});
}
