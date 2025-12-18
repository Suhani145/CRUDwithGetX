import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistwithgetx/controllers/todo_controller.dart';
import '../models/todo.dart';
class TodoFormView extends StatelessWidget {
  final Todo ? todo;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TodoFormView({this.todo}){
    if(todo != null){
      titleController.text = todo!.title;
      descriptionController.text = todo!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height:16),
            ElevatedButton(
                onPressed: () async{
                  if(todo == null){
                   await todoController.addTodo(
                        titleController.text.trim(), descriptionController.text.trim());
                  }
                  else{
                    await todoController.updateTodo(
                        todo!.id!, titleController.text.trim(), descriptionController.text.trim());
                  }
                  Get.back();
                },
                child: Text(todo == null ? "Add" : "Update"),
            )
          ],
        ),
      ),
    );
  }
}
