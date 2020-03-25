import 'package:meta/meta.dart';

// 해당 클래스를 통해 모델은 선언하여 주고 사용할 수 있도록 한다.

class Todo {
  final int id;
  final String title;
  final String contents;
  final String date;
  final bool checked;

  Todo({
    @required this.id,
    @required this.title,
    @required this.contents,
    @required this.date,
    @required this.checked,

});
}

class TodoState {
  // Todo model 타입을 가진 리스트이므로 todoList의 모든 요소들은 Todo 모델 형식을 따라야함.
  final List<Todo> todoList;

  TodoState({
    @required this.todoList,
});

  // 저장된 데이터가 하나도 없기 때문 다음과 같이 초기 상태를 정해주는 과정이 필요함.
  // (더미 데이터를 만들어 사용.)
  factory TodoState.empty() {
    return TodoState (
      todoList: [
        Todo(
          id: 0,
          title: "flutter 공부하기",
          date: "2020.03.24",
          checked: false,
          contents: "flutter란 무엇인가...?"
        ),
        Todo(
          id: 1,
          title: "저녁 메뉴 정하기",
          date: "2020.03.24",
          checked: false,
          contents: "뭐가 맛있을까...?"
        ),
        Todo(
          id: 2,
          title: "솔 놀아주기",
          date: "2020.03.24",
          checked: false,
          contents: "놀아준 후 보상은 츄르가 좋을까 템테이션이 좋을까?"
        ),
      ],
    );
  }

  TodoState update({List<Todo> todoList, String date}) {
    return copyWith(
      todoList: todoList,
    );
  }

  TodoState copyWith({List<Todo> todoList}) {
    return TodoState(todoList: todoList ?? this.todoList);
  }
}