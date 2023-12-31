import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/todo.dart';
import 'package:flutter_todo_app/constants/colors.dart';
import 'package:flutter_todo_app/widgets/todo_item.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todosList;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              children: [               
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:30,bottom:20),
                        child: Text(
                          'Tüm Yapılacaklar',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:EdgeInsets.only(
                    bottom: 50,
                    right: 20,
                    left:20,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(
                      color: Colors.grey,
                      offset:Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Yeni bir yapılacak ekle.',
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom:50,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text('+', style: TextStyle(fontSize: 40,),),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60,60),
                    elevation: 10,
                  ),
                ),
              )
            ]),
          )
        ],
      )
    );
  }

void _handleToDoChange(ToDo todo) {
  setState((){
  todo.isDone = !todo.isDone;
  });
}

void _deleteToDoItem(String id) {
  setState(() {
    todosList.removeWhere((item) => item.id == id);
  });
}

void _addToDoItem(String toDo) {
  setState(() {
    todosList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    ));
  });
  _todoController.clear();
}

void _runFilter(String enteredKeyword) {
  List<ToDo> results = [];
  if( enteredKeyword.isEmpty ){
    results = todosList;
  } else {
    results = todosList
    .where((item) => item.todoText!
        .toLowerCase()
        .contains(enteredKeyword.toLowerCase()))
    .toList();
  }

  setState(() {
    _foundToDo = results;
  });
}

  Widget searchBox() {
    return Container(
              padding:EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 20,
                      minWidth: 25,
                    ),
                    border: InputBorder.none,
                    hintText: 'Arama Yap',
                    hintStyle: TextStyle(color: tdGrey),
                ),
              ),
            );
  }
}