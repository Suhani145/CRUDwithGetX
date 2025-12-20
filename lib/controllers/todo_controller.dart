import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todolistwithgetx/service/database_service.dart';
import '../models/todo.dart';
class TodoController extends GetxController{
  var todos = <Todo>[].obs;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void onInit(){
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _fetchTodo();
    super.onInit();
  }

  Future<void> _fetchTodo() async{
    DBService.instance.fetchAllTasks().then((value)
    {
      for (var element in value) {
        todos.add(Todo(id: element['id'], title: element['title'],
        description: element['description']));
      }
    }
    );
  }

  void addTodo() async{
    await DBService.instance.insert(Todo(title: titleController.text,
    description: descriptionController.text
    ));

    todos.insert(0, Todo(id: todos.length,
    title: titleController.text,
      description: descriptionController.text
    ));
    titleController.clear();
    descriptionController.clear();
  }

  //update the to do
  void updateTodo(int id)async{
    //insert to the db first
    DBService.instance.update(
        id, Todo(id: id,title: titleController.text, description: descriptionController.text));
    //add to the ui
    final index = todos.indexWhere((todo) => todo.id == id);
    if(index != -1){
      todos[index] = Todo(id : id, title: titleController.text, description: descriptionController.text);
    }
    titleController.clear();
    descriptionController.clear();
  }

  //delete the to do
  void deleteTodo(int id) async{
    //insert to the db first
     await DBService.instance.delete(id);
     //show on the ui
    todos.removeWhere((todo)=> todo.id == id);
  }
}



