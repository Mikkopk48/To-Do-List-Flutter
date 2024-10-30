import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  
  const TodoItem({
    super.key, required this.todo, this.onToDoChanged, this.onDeleteItem
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
        tileColor: const Color.fromARGB(255, 250, 251, 252),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank
          ,color:Colors.amber),
        title: Text(todo.todoText! ,style: TextStyle(
          decoration: todo.isDone ? TextDecoration.lineThrough : null ),
          ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:Colors.red,
          ),
          child: IconButton(
            icon: const Icon(
            Icons.delete,color:Colors.white),
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}