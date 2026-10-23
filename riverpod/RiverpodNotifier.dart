import 'package:flutter_riverpod/flutter_riverpod.dart';

//발행하고자 하는 상태 데이터..
class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

//상태를 변경할 수 있는 함수를 가지는 Notifier
class TodosNotifier extends Notifier<List<Todo>> {

  //Notifier 필수 오버라이드.. 자신들이 만들어내는 상태 초기값..
  @override
  List<Todo> build() {
    return [];//상태 초기값..
  }

  void addTodo(Todo todo){
    //state... Notifier내에서 유지되는 상태 데이터..
    state = [...state, todo];
  }

  void toggleTodo(Todo todo) {
    state = [
      for (final t in state)
        if (t == todo)
          Todo(title: t.title, completed: !t.completed)
        else
          t,
    ];
  }

  void deleteTodo(Todo todo) {
    state = state.where((t) => t != todo).toList();
  }
}

//XXXProvider를 이용해 상태 등록.. 어떤 파일에 작성되어 있어도 상관없다..
//top level에 선언만 되면 된다..
//상태 변경을 위한 함수가 별도로 있는 경우 NotifierProvider
//Notifier 타입 - Notifier에 의해 만들어지는 상태 타입
final todosProvider = NotifierProvider<TodosNotifier, List<Todo>>(
  TodosNotifier.new,//객체 생성 , () => TodosNotifier() 축약형..
);


