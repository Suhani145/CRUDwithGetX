import 'package:get/get.dart';
import 'package:todolistwithgetx/service/database_service.dart';
import '../models/todo.dart';
class TodoController extends GetxController{
  final DBService dbService = DBService();
  var todos = <Todo>[].obs;
  var nextId =1;

  @override
  void onInit(){
    super.onInit();
    fetchTodo();
  }
  Future<void> addTodo(String title, String description) async{
    return await dbService.insertTodo(Todo(title:title, description: description));
  }

  Future<void> updateTodo(int id, String title, String description)async{
    return await dbService.updateTodo(
        id, Todo(id: id,title: title, description: description));
  }

  Future<void> deleteTodo(int id) async{
    return await dbService.deleteTodo(id);
  }

  Future<void> fetchTodo() async{
    print("Fetching all todo");
     todos.value= await dbService.fetchAllTodo();
  }
}