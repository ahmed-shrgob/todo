import 'package:flutter1/core/model/todo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TodoVM extends GetxController {
  final box = Hive.box('myBox1');
  //int? id;
  List<Todo> todoList = [];
  List<Todo> getCompletedTodoList(List<Todo> tasks) {
    return tasks.where((e) => e.isDone == true).toList();
  }

  List<Todo> getinCompletedTodoList(List<Todo> tasks) {
    return tasks.where((e) => !e.isDone).toList();
  }

  String? date;
  String? timee;
  int getId() {
    if (box.get('id') != null) {
      
      return box.get('id') + 1;
    } else {
      return 0;
    }
  }

  void addTodo(String text, String? date) {
    box.put('id', getId());
    todoList.add(
        Todo(todoText: text, date: date.toString(), time: null, id: getId()));
    box.put('list1', todoList);
    print(getId());
    update();
  }

  void editTodo(String text, String? date, int id, int index) {
    print(id);
    todoList[index] =
        Todo(todoText: text, date: date.toString(), time: null, id: id);
    box.put('list1', todoList);
    update();
  }

  void deletTodo(int index) async {
    todoList.removeAt(index);
    box.put('list1', todoList);
    update();
  }

  void readTodoList() async {
    if (box.keys.contains('list1')) {
      dynamic data = box.get('list1');
      if (data is List<dynamic>) {
        todoList = List<Todo>.from(data);
      }
    }
  }

  changeTodoStute(int index) {
    if (todoList[index].isDone) {
      todoList[index].isDone = false;
    } else {
      todoList[index].isDone = true;
    }
    box.put('list1', todoList);
    update();
  }

  updateValue() {
    update();
  }

  @override
  void onInit() {
    readTodoList();
    print('oninit');
    super.onInit();
  }
}
