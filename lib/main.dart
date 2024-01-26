// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter1/core/model/todo.dart';
import 'package:flutter1/core/model/userSettingVM.dart';
import 'package:flutter1/core/view/screens/main_screen.dart';
import 'package:flutter1/notification.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox('myBox1');
  await LocalNotificationService().init();

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
final box=Hive.box('myBox1');
final settingControl=Get.put(UserSettingVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSettingVM>(
      builder: (controller) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Get.deviceLocale,
        theme:controller.getTheme()? ThemeData.dark():ThemeData.light(),
        home: MainScreen(),
      ),
    );
  }
}
