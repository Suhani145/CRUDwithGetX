import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistwithgetx/controllers/todo_controller.dart';
import 'package:todolistwithgetx/views/todo_form_view.dart';
class HomeView extends StatelessWidget {
 final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo App"),),
      body: Obx(()=> ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index){
            final todo = todoController.todos[index];
            return ListTile(
             title: Text(todo.title),
              subtitle: Text(todo.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed:(){
                        Get.to(()=> TodoFormView(todo: todo));
                        } ,
                      icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: (){
                      todoController.deleteTodo(todo.id);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            );
          }
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(()=> TodoFormView());
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
