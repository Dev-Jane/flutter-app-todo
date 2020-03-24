import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class TodoListEvent extends Equatable {
  TodoListEvent([List props = const []]) : super(props);
}

class TodoPageLoaded extends TodoListEvent {

  @override
  String toString() {
    // TODO: implement toString
    return "TodoPageLoaded";
  }
}

// 각각의 todoList 들의 check box들이 클릭이 됐을 때 일어날 event
// index를 받는 이유는 ListView.builder를 사용하여 화면을 그려줄 예정이기 때문
class TodoListCheck extends TodoListEvent {
  final int index;

  TodoListCheck({@required this. index});

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck";
  }
}