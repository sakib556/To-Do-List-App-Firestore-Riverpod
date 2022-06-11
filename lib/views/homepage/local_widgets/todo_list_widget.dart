import 'package:flutter/material.dart';
import 'package:to_do_list_riverpod/views/homepage/local_widgets/todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  TodoListWidget({Key? key}) : super(key: key);
  // final TodosController _todosController = Get.put(TodosController());
  @override
  Widget build(BuildContext context) {
    // _todosController.fetchTodos();
    return Expanded(
        child: ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 8),
      itemCount: 15,
      itemBuilder: (context, i) {
        // var todo = _todosController.todoList[i];
        return GestureDetector(
          child: TodoWidget(),
          onTap: () {
            // Get.to(() => TodoDetails(todo));
          },
        );
      },
    ));
  }
}
