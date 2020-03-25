import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptodo/todo_add.dart';

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

// add 관련 이벤트 추가
// AddDateChanged -> 달력에서 날짜 설정 이벤트
class AddDateChanged extends TodoListEvent {
  final String date;

  AddDateChanged({
    @required this.date,
  });

  String toString() {
    // TODO: implement toString
    return "AddDateChanged {date: $date}";
  }
}

// TodoAddPressed -> 새로운 일정 추가하기 버튼 event
// todo의 id, title, contenns, date를 받아 온다.
class TodoAddPressed extends TodoListEvent {
  final int id;
  final String title;
  final String date;
  final String contents;

  TodoAddPressed({
    @required this.id,
    @required this.title,
    @required this.date,
    @required this.contents,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "TodoListCheck {id: $id, title: $title, date: $date, contents: $contents}";
  }
}