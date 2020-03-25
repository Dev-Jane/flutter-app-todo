import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapptodo/blocs/models/todoModel.dart';
import 'package:flutterapptodo/blocs/todoBloc/todo_bloc.dart';
import 'package:intl/intl.dart';

import 'blocs/todoBloc/todo_event.dart';

class TodoAdd extends StatefulWidget {
  _TodoAdd createState() => _TodoAdd();
}

class _TodoAdd extends State<TodoAdd> {
  // ignore: close_sinks

  // 앞서 생성 된 Todo Bloc을 계속해서 사용 할 것.
  TodoBloc _todoBloc;

  // todo의 제목을 위한 컨트롤러, 설명을 위한 컨트롤러 그리고 내가 지정한 날짜를 위한 컨트롤러 세가지를 선언
  TextEditingController title = TextEditingController();
  TextEditingController contents = TextEditingController();
  String selectDate;

  static DateTime now = DateTime.now();

  // 받아 온 DateTime을 특정 형태로 바꾸는 방법
  String formattedDate = new DateFormat('yyyy년 MM월 dd일').format(now);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 앞서 생성된 블럭을 받아와 계속해서 사용
    _todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener(
      listener: (BuildContext context, TodoState state) {} ,
      bloc: _todoBloc,
      child: BlocBuilder (
      bloc: _todoBloc,
      builder: (BuildContext context, TodoState state) {
         return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Todo Add"),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 여기서 부터 메모까지는 간단하게 Text, TextFiled를 활용
                Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text('할 일',
                      style: Theme.of(context).textTheme.display1,
                    )),
                TextField(
                  decoration: InputDecoration(hintText: '무엇을 하실건가요?'),
                  controller: title,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Text('메모',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                /*
                * 특이한 점이 있다면 이 부분에서는 TextField에 기본적으로 있는 border를 없애고
                * Container로 감싸주어 richTextField 처럼 보이게 만들어 주었다는 것이다
                */
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.7,
                    ),
                  ),
                  child: TextField (
                    cursorColor: Theme.of(context).primaryColor,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: contents,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    '날짜',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                /*
            * 여기서는 달력을 dialog로 보여주기 위한 작업이 들어가 있다
            * flutter에서 기본으로 제공하고 있음 그래서 onTab을 했을때 해당 기능을 불러와 사용하면 됨.
            * 하지만 달력에서 날짜를 선택하였을때 버튼에 날짜를 어떻게 블록을 이용하여 변경해주어야 하는가에 대해 생각해보아야 한다.
            */
                OutlineButton(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        // selectDate가 존재하면 selectDate를 보여주고 없다면 formattedDate
                        selectDate != null ? Text(selectDate) : Text(formattedDate)
                      ],
                    ),
                  ),
                  onPressed: () {
                    _selectDate(context, state);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Container(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Center(
                    child:  RaisedButton(
                      // 버튼의 모양일 둥굴게 바꿔 주는 부분
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Color(0xFF266DAC)),
                      ),
                      color: Color(0xFF266DAC),
                      // 이 부분을 통해서 todo에 반드시 데이터가 들어가야 함을 dialog를 통해 보여준다
                      // 만약 title부분에 데이터가 있으면 저장하는 과정이 실행 되도록 한다.
                      onPressed: () {
                        if(title.text.isNotEmpty) {
                          _todoBloc.add(TodoAddPressed(
                              id: 0,
                              title: title.text,
                              contents: contents.text,
                              date: selectDate
                          ));
                          Navigator.pop(context);
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false, // 버튼을 탭 해야만 한다. true -> 안해도 됨
                              builder: (BuildContext context) { // BuildContext, context 때문에 에러 뜸...
                                return AlertDialog(
                                  title: Text('할 일 색션을 채워주세요!'),
                                  content: Text('Select button you want'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context, "OK");
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 55,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add),
                            Text('새로운 일정 추가하기',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    ));
  }

  Future<void> _selectDate(BuildContext context, TodoState state) async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
    );
    selectDate = DateFormat('yyyy.MM.dd').format(date);
    _todoBloc.add(AddDateChanged(date: selectDate));
  }

}