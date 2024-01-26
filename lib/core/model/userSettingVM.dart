import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserSettingVM extends GetxController {
  final box = Hive.box('myBox1');
 late bool isDark ;
  static ThemeData dark = ThemeData.dark();
  static ThemeData light = ThemeData.light();
  bool getTheme() {
    return box.get('theme') ?? true;
  }

  changeTheme(bool selector) {
    if (selector == true) {
      isDark = true;
      box.put('theme', true);
      Get.changeTheme(dark);
    } else {
      isDark = false;
      box.put('theme', false);
      Get.changeTheme(light);
    }
    update();
  }
}
