import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterapptodo/blocs/models/todoModel.dart';
import 'package:flutterapptodo/blocs/todoBloc/todo_event.dart';
import 'package:flutterapptodo/todo_list.dart';

class TodoBloc extends Bloc<TodoListEvent, TodoState> {
  // TODO: implement initialState
  // 가장 먼저 일어나게 state의 초기화 작업
  @override
  TodoState get initialState => TodoState.empty();

  Stream<TodoState> mapEventToState(TodoListEvent event) async* {
    // TODO: implement mapEventToState
    if(event is TodoPageLoaded) {
      yield* _mapTodoPageLoadedToState();
    } else if (event is TodoListCheck) {
      yield* _mapTodoListCheckToState(event.index);
    }
    // 추가 부분
    else if (event is AddDateChanged) {
      yield* _mapAddDateChangedToState(event.date);
    } else if (event is TodoAddPressed) {
      yield* _mapTodoAddPressedToState(
          event.id, event.title, event.date, event.contents
      );
    }
  }

  Stream<TodoState> _mapTodoPageLoadedToState() async* {
    yield state.update(todoList: state.todoList);
  }

  // Todo model을 만들 때 checked라는 변수가 존재함 해당 변수는 내가 현재 클릭한 Todo를 선택 했었는지 아니였는지 확인을 위해 만들어 둔것.
  // 그래서 선택이 되어있는 상황이면 false, 선택이 되어있지 않은 상태는 true로 바꿔주는 작업이 필요
  // state.todoList에서 해당 index의 값을 새로이 삽입하여 업데이트 시키는 과정

  Stream<TodoState> _mapTodoListCheckToState(int index) async* {
    Todo currentTodo = Todo (
      id: state.todoList[index].id,
      title: state.todoList[index].title,
      date: state.todoList[index].date,
      contents: state.todoList[index].contents,
      checked: state.todoList[index].checked == true ? false : true
    );
    List<Todo> cTodoList = state.todoList;
    cTodoList[index] = currentTodo;
    yield state.update(todoList: cTodoList);
  }

  // 데이트를 받아 state를 업데이트 한다.
  Stream<TodoState> _mapAddDateChangedToState(String date) async* {
    yield state.update(date: date);
  }

  // 추가 버튼을 눌렀을 때 Todo model로 만들어 주어야 하고 만들어준 model을 리스트에 넣어준다. 그리고 갱신된 리스트로 state를 업데이트 시킨다.
  Stream<TodoState> _mapTodoAddPressedToState(int id, String title, String date, String contents) async* {
    Todo newTodo = Todo(id: id, title: title, date: date, contents: contents, checked: false);

    List<Todo> currentTodo = state.todoList;
    currentTodo.add(newTodo);

    yield state.update(todoList: currentTodo);
  }
}

// 위와 같은 작업이 완료되면 TodoList 화면을 그려주면 된다. 앞에서 말한것과 같이 ListView.Builder를 사용하여 Todo 타입의 리스트를 불러와 하나씩 그려주게 만들것