// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter1/core/model/userSettingVM.dart';
import 'package:flutter1/core/view/widgets/AlertDialog.dart';
import 'package:flutter1/core/view/widgets/todo_widget.dart';
import 'package:flutter1/core/model/todoVM.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final control = Get.put(TodoVM());
  UserSettingVM settingControl = Get.find();

  Future _showDolingo(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialogScreen(
          date: null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('To do'),
          centerTitle: true,
          elevation: 0,
          backgroundColor:
              settingControl.getTheme() ? Colors.grey[800] : Colors.blueGrey,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color:settingControl.getTheme()? Colors.amberAccent:Colors.blueGrey),
                  accountName: Text(
                    'setting',
                    style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                  ),
                  accountEmail: null),
              GetBuilder<UserSettingVM>(
                init: UserSettingVM(),
                builder: (controller) {
                  return SwitchListTile(
                    title: Text('dark theme'),
                    value: controller.getTheme(),
                    onChanged: (value) {
                      controller.changeTheme(value);
                    },
                  );
                },
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: settingControl.getTheme()
                        ? Colors.grey[800]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(30)),
                child: TabBar(
                    indicatorPadding: EdgeInsets.all(8),
                    unselectedLabelColor: settingControl.getTheme()
                        ? Colors.grey
                        : Colors.blueGrey,
                    labelColor:
                        settingControl.getTheme() ? Colors.black : Colors.white,
                    indicator: BoxDecoration(
                        color: settingControl.getTheme()
                            ? Colors.white
                            : Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30)),
                    tabs: [
                      Tab(child: Text('الكل')),
                      Tab(child: Text('غير المكتملة')),
                      Tab(child: Text('المكتملة')),
                    ]),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TodoWidget(
                    tipe: null,
                  ),
                  TodoWidget(tipe: true),
                  TodoWidget(tipe: false),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: settingControl.getTheme() ? Colors.black : Colors.white,
            weight: 0.7,
          ),
          onPressed: () {
            _showDolingo(context);
          },
          backgroundColor:
              settingControl.getTheme() ? Colors.grey[300] : Colors.blueGrey,
        ),
      ),
    );
  }
}
