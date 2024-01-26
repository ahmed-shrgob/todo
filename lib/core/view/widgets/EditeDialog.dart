// import 'package:flutter/material.dart';
// import 'package:flutter1/core/model/todoVM.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// // ignore: must_be_immutable
// class EditeAlertDialogScreen extends StatelessWidget {
//   late String date;
//   late String timee;
//   late String text;
//   late int index;
//   TextEditingController _controller;

//   EditeAlertDialogScreen(
//       {Key? key,
//       required this.date,
//       required this.timee,
//       required this.text,
//       required this.index})
//       : _controller = TextEditingController(text: text),
//         super(key: key);
//   TodoVM control = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     void _showDatePicker() {
//       showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2040),
//       ).then((value) {
//         date = value.toString();
//         control.updateValue();
//       });
//     }

//     void _showTimePicker() {
//       showTimePicker(context: context, initialTime: TimeOfDay.now())
//           .then((value) {
//         TimeOfDay? time = value;

//         timee = DateFormat('h:mm a').format(DateTime(
//           DateTime.now().year,
//           DateTime.now().month,
//           DateTime.now().day,
//           time!.hour,
//           time.minute,
//         ));
//         control.updateValue();
//       });
//     }

//     return AlertDialog(
//       title: Text('Add Task'),
//       content: Container(
//         height: 200,
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               maxLines: 2,
//               minLines: 1,
//               maxLength: null,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             GetBuilder<TodoVM>(builder: (x) {
//               return ListTile(
//                 leading: IconButton(
//                   onPressed: _showDatePicker,
//                   icon: const Icon(Icons.date_range_rounded),
//                 ),
//                 title: Text(
//                   date == "null"
//                       ? "Add Date"
//                       : date.toString().substring(0, 10),
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               );
//             }),
//             ListTile(
//               leading: IconButton(
//                 onPressed: _showTimePicker,
//                 icon: const Icon(Icons.access_time_outlined),
//               ),
//               title: GetBuilder<TodoVM>(
//                 builder: (x) => Text(
//                   timee == "null" ? "Add Time" : timee.toString(),
//                   style: const TextStyle(color: Colors.grey),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text(
//             'Cancel',
//             style: TextStyle(color: Colors.amber),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             if (_controller.text.isNotEmpty) {
//               control.editTodo(_controller.text, date, timee, index);
//               _controller.clear();
//               Navigator.of(context).pop();
//             }
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text("لا يمكن ترك الحقل فارغاً")));
//           },
//           child: Text(
//             'Edit',
//             style: TextStyle(color: Colors.amber),
//           ),
//         ),
//       ],
//     );
//   }
// }
