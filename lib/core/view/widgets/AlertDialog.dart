import 'package:flutter/material.dart';
import 'package:flutter1/core/model/todoVM.dart';
import 'package:flutter1/notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AlertDialogScreen extends StatelessWidget {
  DateTime? date;
  bool isEdit;
  String? editText;
  int? index;
  int? id;
  // TextEditingController? editController;
  AlertDialogScreen(
      {super.key,
      required this.date,
      this.editText,
      this.id,
      // this.editController,
      this.isEdit = false,
      this.index});
  TodoVM control = Get.find();
  TextEditingController _controller = TextEditingController();
  //DateTime? date;
  //TimeOfDay? timee;

  @override
  Widget build(BuildContext context) {
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
      ).then((value) {
        date = value;
        control.updateValue();
      });
    }

    void _showTimePicker() {
      showTimePicker(context: context, initialTime: TimeOfDay.now())
          .then((value) {
        date = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          value!.hour,
          value.minute,
        );
        control.updateValue();
      });
    }

    return AlertDialog(
      title: Text('Add Task'),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: _controller = TextEditingController(text: editText),
              maxLines: 2,
              minLines: 1,
              maxLength: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            GetBuilder<TodoVM>(builder: (x) {
              return ListTile(
                leading: IconButton(
                  onPressed: _showDatePicker,
                  icon: const Icon(Icons.date_range_rounded),
                ),
                title: Text(
                  date == null
                      ? "Add Date"
                      : DateFormat('EEE, M/d/y').format(date!),
                  style: const TextStyle(color: Colors.grey),
                ),
              );
            }),
            ListTile(
              leading: IconButton(
                onPressed: _showTimePicker,
                icon: const Icon(Icons.access_time_outlined),
              ),
              title: GetBuilder<TodoVM>(
                builder: (x) => Text(
                  date == null
                      ? "Add Time"
                      : DateFormat('h:mm a').format(date!),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.amber),
          ),
        ),
        TextButton(
          onPressed: () {
            if (isEdit == false) {
              if (_controller.text.isNotEmpty) {
                control.addTodo(_controller.text, date.toString());
                if (date != null) {
                  LocalNotificationService().tzShow(
                      id: control.getId(),
                      title: 'بطل كسل وسوي مهمتك',
                      body: _controller.text,
                      time: date!);
                }

                _controller.clear();
              }
            } else {
              if (_controller.text.isNotEmpty) {
                control.editTodo(
                    _controller.text, date.toString(), id!, index!);
                if (date != null) {
                  LocalNotificationService().tzShow(
                      id: id!,
                      title: 'بطل كسل وسوي مهمتك',
                      body: _controller.text,
                      time: date!);
                }
              }
            }

            Navigator.of(context).pop();
            // kkkk
          },
          child: Text(
            isEdit==false?'Add':'Edit',
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ],
    );
  }
}
