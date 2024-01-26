// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter1/core/model/todoVM.dart';
import 'package:flutter1/core/model/userSettingVM.dart';
import 'package:flutter1/core/view/widgets/AlertDialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoWidget extends StatelessWidget {
  bool? tipe;
  TodoWidget({super.key, required this.tipe});
  TodoVM control = Get.find();
  UserSettingVM settingControl = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoVM>(
      builder: (control) => ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: control.todoList.length,
        itemBuilder: (context, index) {
          if (control.todoList[index].isDone != tipe || tipe == null) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Slidable(
                endActionPane: ActionPane(motion: StretchMotion(), children: [
                  SlidableAction(
                    onPressed: (contex) {
                      control.deletTodo(index);
                    },
                    backgroundColor: Colors.redAccent,
                    icon: Icons.delete,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  SlidableAction(
                    onPressed: (contex) {
                      //control.deletTodo(index);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialogScreen(
                            id: control.todoList[index].id,
                            editText: control.todoList[index].todoText,
                            date: control.todoList[index].date != 'null'
                                ? DateTime.parse(control.todoList[index].date!)
                                : null,
                            index: index,
                            isEdit: true,
                          );
                          // EditeAlertDialogScreen(
                          //   date: control.todoList[index].date!,
                          //   timee: control.todoList[index].time!,
                          //   text: control.todoList[index].todoText,
                          //   index: index,
                          // );
                        },
                      );
                    },
                    backgroundColor: Colors.blueAccent,
                    icon: Icons.edit,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ]),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:settingControl.getTheme()? Colors.grey[800]:Colors.grey[200],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Checkbox(
                        activeColor: Colors.amberAccent,
                        checkColor: Colors.grey[800],
                        value: (control.todoList[index].isDone),
                        onChanged: (value) {
                          control.changeTodoStute(index);
                        },
                      ),
                      title: Text(
                        control.todoList[index].todoText,
                        style: TextStyle(
                            fontWeight: control.todoList[index].isDone
                                ? FontWeight.normal
                                : FontWeight.bold,
                            decoration: control.todoList[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            control.todoList[index].date != "null"
                                ? DateFormat('E/ d/ y').format(DateTime.parse(
                                    control.todoList[index].date!))
                                : '',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          Text(
                              control.todoList[index].date != "null"
                                  ? DateFormat('h:mm a').format(DateTime.parse(
                                      control.todoList[index].date!))
                                  : '',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
