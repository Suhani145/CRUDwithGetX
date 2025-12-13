import 'package:get/get.dart';
import '../models/todo.dart';
class TodoController extends GetxController{
  var todos = <Todo>[].obs;
  var nextId =1;

  void addTodo(String title, String description){
    todos.add(Todo(id: nextId++, title: title, description: description));
  }

  void updateTodo(int id, String title, String description){
    var todoIndex = todos.indexWhere((todo) => todo.id == id);
    todos[todoIndex] = Todo(id: id, title: title, description: description);
  }

  void deleteTodo(int id){
    todos.removeWhere((todo)=> todo.id == id);
  }
}