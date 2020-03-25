import 'package:flutter/cupertino.dart';
import 'package:flutterapptodo/blocs/models/todoModel.dart';
import 'package:intl/intl.dart';

class TodoState {
  final List<Todo> todoList;
  final String date;

  TodoState({
    @required this.todoList,
    @required this.date,
  });

  factory TodoState.empty() {
    return TodoState(
      todoList: [
        Todo(
          id: 0,
          title: "파판 레이드 돌기",
          date: "2020.03.25",
          checked: false,
          contents: "예리는 접속할까?"
        ),
        Todo(
          id: 1,
          title: "동숲 하기!",
          date: "2020.03.25",
          checked: false,
          contents: "갓겜!",
        ),
      ],
      date: DateFormat('yyyy.MM.dd').format(DateTime.now()).toString(),
    );
  }

  TodoState update({
    List<Todo> todoList,
    String date,
}) {
    return copyWith(
      todoList: todoList,
      date: date,
    );
  }

  TodoState copyWith({
    List<Todo> todoList,
    String date,
}) {
    return TodoState(
      todoList: todoList ?? this.todoList,
      date: date ?? this.date,
    );
  }
}