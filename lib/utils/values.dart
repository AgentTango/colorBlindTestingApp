import 'package:flutter/foundation.dart';

const List<String> normal = [
  "12",
  "8",
  "6",
  "29",
  "57",
  "5",
  "3",
  "15",
  "74",
  "2",
  "6",
  "97",
  "45",
  "5",
  "7",
  "16",
  "73",
  "",
  "",
  "",
  ""
];

const List<String> redGreen = [
  "12",
  "3",
  "5",
  "70",
  "35",
  "2",
  "5",
  "17",
  "21",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "5",
  "2",
  "45",
  "73"
];

const List<String> total = [
  "12",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  ""
];
enum Result { Normal, Red_Green_Deficiency, Total_Color_Blindness, Not_Sure }
Result check(List<String> a) {
  if (listEquals(a, normal) == true) {
    return Result.Normal;
  } else if (listEquals(a, redGreen) == true) {
    return Result.Red_Green_Deficiency;
  } else if (listEquals(a, total) == true) {
    return Result.Total_Color_Blindness;
  }else{
    return Result.Not_Sure;
  }
}
