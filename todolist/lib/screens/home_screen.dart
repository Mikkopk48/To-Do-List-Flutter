import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';

import 'package:todolist/widgets/todo_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final todosList = ToDo.todoList();
List<ToDo> _foundToDo = [];
final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        appBar: _buildAppBar(),
        body: Stack(
          children: [
           searchBox(),
          _listaWidgets(),
          _addToDoBox()
          ],
        ),
      ),
    );
  }

  Align _addToDoBox() {
    return Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Container(
              height: 55,
            margin:const EdgeInsets.only(bottom: 23,right:20,left: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:const [BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
              )],
              borderRadius: BorderRadius.circular(10)
            ), 
            child: TextField(
              controller: _todoController,
              decoration: const InputDecoration(
                hintText: 'Add a new ToDo',
                border: InputBorder.none
              ),
            ),
             ),
             ),
             Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                right: 20,
              ),
              child: ElevatedButton(
              
              onPressed: (){
                _addToDoItem(_todoController.text);
              }, 
              child: const Text("+",style: TextStyle(fontSize:40)),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                minimumSize: const Size(60, 60),
                foregroundColor: Colors.white,backgroundColor: Colors.amber)

              ),
             ),
          ],),
        );
  }

  Expanded _listaWidgets() {
    return Expanded(
            child: ListView(
             children: [
              Container(
                margin:const EdgeInsets.only(top:50,bottom:20),
                child:const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text("All Yours ToDos",
                  style:TextStyle(fontFamily: 'Roboto',
                    fontSize: 30,fontWeight:FontWeight.bold)),
                ),
              ),
              for(ToDo todo in _foundToDo.reversed)
              TodoItem(todo:todo,
              onToDoChanged: _handleToDoChange,
              onDeleteItem: _deleteToDoItem,
              ),
             ],),
          );
  }
  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
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


void _handleToDoChange(ToDo todo){
  setState(() {
    todo.isDone = !todo.isDone;
  });
}
void _deleteToDoItem(String id){
  setState(() {
    todosList.removeWhere((item) => item.id == id);
  });
}

void _addToDoItem(String toDo){
  setState(() {
    todosList.add(ToDo(id:DateTime.now().microsecond.toString()
  ,todoText: toDo,));
  });
  _todoController.clear();
}

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }



  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      title: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: Colors.white,
        ),
        Text(
          'To Do List',
          style: TextStyle(color: Colors.white
          ,fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.account_circle,
          color: Colors.white,
        )
      ]),
    );
  }
}
