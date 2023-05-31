import 'package:flutter/cupertino.dart';

class TaskNotifier with ChangeNotifier {
  String _enteredText = "";
  List<String> tasks = ["Task 1"];

  set enteredText(String value) {
    _enteredText = value;
  }

  String get enteredText => _enteredText;

  void addTask(String taskName) {
    tasks.add(taskName);
    notifyListeners();
  }
}
