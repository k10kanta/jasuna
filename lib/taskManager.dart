import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskManarger {
  late Ref ref;
  late String title;
  late List<Color> colorList;
  late Map colorMap = {
    //色の種類をここで宣言する
    //グラデの参考はここから「https://webgradients.com/」
    "073 Love Kiss": const [
      Color.fromRGBO(255, 8, 68, 1),
      Color.fromRGBO(255, 177, 153, 1),
    ],
    "133 Orange Juice": const [
      Color.fromRGBO(252, 96, 118, 1),
      Color.fromRGBO(255, 154, 68, 1),
    ],
    "021 True Sunset": const [
      Color.fromRGBO(250, 112, 154, 1),
      Color.fromRGBO(254, 225, 64, 1),
    ],
    "001 Warm Flame": const [
      Color.fromRGBO(250, 208, 196, 1),
      Color.fromRGBO(255, 154, 158, 1),
    ],
    "002 Night Fade": const [
      Color.fromRGBO(251, 194, 235, 1),
      Color.fromRGBO(161, 140, 209, 1),
    ],
    "019 Malibu Beach": const [
      Color.fromRGBO(79, 172, 254, 1),
      Color.fromRGBO(0, 242, 254, 1),
    ],
    "020 New Life": const [
      Color.fromRGBO(155, 225, 93, 1),
      Color.fromRGBO(0, 227, 174, 1),
    ],
    "012 Tempting Azure": const [
      Color.fromRGBO(132, 250, 176, 1),
      Color.fromRGBO(143, 211, 244, 1),
    ],
    "104 Crystalline": const [
      Color.fromRGBO(0, 205, 172, 1),
      Color.fromRGBO(141, 218, 213, 1),
    ],
    "070 Aqua Splash": const [
      Color.fromRGBO(19, 84, 122, 1),
      Color.fromRGBO(128, 208, 199, 1),
    ],
    "028 Plum Plate": const [
      Color.fromRGBO(102, 126, 234, 1),
      Color.fromRGBO(118, 75, 162, 1),
    ],
    "039 Deep Blue": const [
      Color.fromRGBO(106, 17, 203, 1),
      Color.fromRGBO(37, 117, 252, 1),
    ],
    "091 Eternal Constance": const [
      Color.fromRGBO(30, 60, 114, 1),
      Color.fromRGBO(42, 82, 152, 1),
    ],
    "057 Dirty Beauty": const [
      Color.fromRGBO(186, 200, 224, 1),
      Color.fromRGBO(106, 133, 182, 1),
    ],
    "082 Desert Hump": const [
      Color.fromRGBO(199, 144, 129, 1),
      Color.fromRGBO(223, 165, 121, 1),
    ],
  };
  late Map typeMap = {
    //デフォルトのタイプをここで定義する
    "勉強": const [
      Color.fromRGBO(79, 172, 254, 1),
      Color.fromRGBO(0, 242, 254, 1),
    ],
    "仕事": const [
      Color.fromRGBO(255, 8, 68, 1),
      Color.fromRGBO(255, 177, 153, 1),
    ],
    "運動": const [
      Color.fromRGBO(102, 126, 234, 1),
      Color.fromRGBO(118, 75, 162, 1),
    ],
    "遊び": const [
      Color.fromRGBO(250, 112, 154, 1),
      Color.fromRGBO(254, 225, 64, 1),
    ],
    "ゆったり": const [
      Color.fromRGBO(155, 225, 93, 1),
      Color.fromRGBO(0, 227, 174, 1),
    ],
    "睡眠": const [
      Color.fromRGBO(30, 60, 114, 1),
      Color.fromRGBO(42, 82, 152, 1),
    ],
  };
}
