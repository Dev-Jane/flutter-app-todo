import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapptodo/blocs/todoBloc/todo_bloc.dart';
import 'package:flutterapptodo/blocs/todoBloc/todo_event.dart';
import 'package:flutterapptodo/todo_add.dart';

import 'blocs/models/todoModel.dart';

class TodoList extends StatefulWidget {
  _TodoList createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  TodoBloc _todoBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    _todoBloc.add(TodoPageLoaded());
  }

  @override
  Widget build(BuildContext context) {
    print('check $context');
    // TODO: implement build

    return BlocListener(
        bloc: _todoBloc,
        listener: (BuildContext context, TodoState state) {},
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Todo List"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider.value(value: _todoBloc, child: TodoAdd())));
                }),
            ],
          ),
          body: BlocBuilder(
            bloc: _todoBloc,
            builder: (BuildContext context, TodoState state){
              print('check@@@@ $state');
              return Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height /2,
                    child: ListView.separated( // .build 를 쓰면 divider 없이 사용 가능
                      itemCount: state.todoList.length,
                      // ignore: missing_return
                      itemBuilder: (BuildContext context, int index) {
                        if(state.todoList[index].checked==false) {
                          return ListTile(
                            title: Text(state.todoList[index].title),
                            onTap: () {
                              _showDialog(state.todoList[index].title,
                                state.todoList[index].contents,
                                state.todoList[index].date,
                                state.todoList[index].checked,
                              );
                            },
                            leading: Checkbox(
                              value: state.todoList[index].checked,
                              onChanged: (bool newValue) {
                                _todoBloc.add(TodoListCheck(index: index));
                              },
                            ),
                          );
                        }
                      },
                      // separatorBuilder 가 있어야 divider 가 제대로 적용된다. 없이 사용하려면 지우기!
                      separatorBuilder: (context, index) {
                        return Divider();
                      }),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/5,
                    child: ListView.separated(
                        itemCount: state.todoList.length,
                        // ignore: missing_return
                        itemBuilder: (BuildContext context, int index){
                          if(state.todoList[index].checked==true) {
                            return ListTile(
                              title: Text(state.todoList[index].title),
                              onTap: () {
                                _showDialog(state.todoList[index].title,
                                  state.todoList[index].contents,
                                  state.todoList[index].date,
                                  state.todoList[index].checked,
                                );
                              },
                              leading: Checkbox(
                                value: state.todoList[index].checked,
                                onChanged: (bool newValue) {
                                  _todoBloc.add(TodoListCheck(index: index));
                                },
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }

  // 눌렀을때 부가적인 설명에 대한 dialog가 나올 수 이도록 하기 위한 작업
  // 일단은 title, contents를 받아 다이얼로그 페이지에 보일 수 있게 하자.
void _showDialog(String title, String contents, String date, bool checked) async {
  print('check date: $date');
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: contents.isNotEmpty ? Text(contents) : Text("내용 없음"),
          actions: <Widget>[
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context, "확인");
              },
            )
          ],
        );

    },
    );
}
}