import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_list_riverpod/models/todo.dart';

List<Todo> todolist = [];
final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  return TodoList(todolist);
});

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  // void add(String description) {
  //   state = [
  //     ...state,
  //     Todo(
  //       id: todo.id,
  //       description: description,
  //     ),
  //   ];
  // }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
