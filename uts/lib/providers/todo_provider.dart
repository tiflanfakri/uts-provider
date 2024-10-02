import 'package:flutter/material.dart';
import '/models/todo.dart'; 

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  void addTask(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();  
  }
  void removeTask(int index) {
    _todos.removeAt(index);
    notifyListeners();  
  }
  void toggleTaskStatus(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();  
  }
}
