import 'package:flutter/material.dart';
//provider로 이용하기 위한 상태 데이터..

class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted(){
    completed = !completed;
  }
}

//조상에서 provider로 공개할 상태 데이터.. 상태와 상태 변경 함수 등록..
class TodosModel extends ChangeNotifier{
  List<Todo> todos = [];

  void addTodo(Todo todo){
    todos.add(todo);
    notifyListeners();
  }

  void toggleTodo(Todo todo){
    var index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}