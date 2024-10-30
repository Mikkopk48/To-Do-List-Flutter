class ToDo{
  String? id;
  String? todoText;
  bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
  static List<ToDo> todoList(){
    return[
      ToDo(id: '01',todoText: 'Exercise',isDone:true),
      ToDo(id: '02',todoText: 'Homework',isDone:false),
      ToDo(id: '03',todoText: 'Clean',isDone:false),
      ToDo(id: '04',todoText: 'Do flash cards',isDone:false),
      ToDo(id: '05',todoText: 'Study',isDone:false),
      ToDo(id: '06',todoText: 'Exercise',isDone:true),
      ToDo(id: '07',todoText: 'Clean Clothes',isDone:false),
      ToDo(id: '08',todoText: 'Yournaling',isDone:false),
      
    ];
  }
}