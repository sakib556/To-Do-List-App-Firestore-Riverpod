import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_list_riverpod/controllers/todos_notifier.dart';

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.all);
final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();
final uncompletedTodosCount = Provider<int>((ref) {
  return ref
      .watch(todoListProvider)
      .where((todo) => todo.completed == 0)
      .length;
});
