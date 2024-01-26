import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late String todoText;
  @HiveField(2)
  String? date;
  @HiveField(3)
  String? time;
  @HiveField(4)
  bool isDone = false;
  @HiveField(5)
  int id=0;
  Todo({required this.todoText, required this.date, required this.time,required this.id});
}
