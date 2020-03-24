import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapptodo/todo_add.dart';
import 'package:flutterapptodo/todo_list.dart';
import 'blocs/todoBloc/bloc.dart';
import 'blocs/todoBloc/todo_bloc.dart';


void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      // TODO: implement build
      // BlocProvider로 사용해도 되지만 기능 추가를 위해 미리 MultiProvider로 선언
      providers: [
        BlocProvider<TodoBloc> (
          create: (BuildContext context) => TodoBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Todo',
        // 앱의 전체적인 테마를 설정
        theme: ThemeData(
          primaryColor: Color(0xFFF8F8F8),
          backgroundColor: Color(0xFFF8F8F8),
          scaffoldBackgroundColor: Color(0xFFF8F8F8),
          accentColor: Color(0xFF3A5EFF)
        ),
        // 가장 먼저 실행 될 부분이 무엇인지 정해주는 부분 대개 splash페이지 혹은 login 페이지로 설정함.
        home: TodoList(),

        // Navigator.of(context).pushNamd(route name); 형식으로 써주기 위해 선언
        routes: {
          "/todoList" : (BuildContext context) => TodoList(),
          "/todoAdd" : (BuildContext context) => TodoAdd(),
        },
      ),
    );
  }
}




