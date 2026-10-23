import 'package:bloc/bloc.dart';
import 'event/TodosEvent.dart';
import 'state/TodoState.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState>{
  TodosBloc(): super(TodosState([])){//상위 생성자, 매개변수에 상태 초기값..
    //이벤트 콜백 등록..
    on<AddTodoEvent>((event, emit){
      //state.. 이벤트 발생 이전의 상태 데이터..
      List<Todo> newTodos = List.from(state.todos)
          ..add(event.todo);
      //새로운 상태 발행..
      emit(TodosState(newTodos));
    });

    on<DeleteTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..remove(event.todo);
      emit(TodosState(newTodos));
    });

    on<ToggleCompletedTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });

  }

  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }

}