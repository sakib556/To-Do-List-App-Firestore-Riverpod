import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_list_riverpod/controllers/todofillter.dart';
import 'package:to_do_list_riverpod/controllers/todos_notifier.dart';
import 'package:to_do_list_riverpod/controllers/todos_provider.dart';
import 'package:to_do_list_riverpod/services/todo_sevices.dart';
import 'package:to_do_list_riverpod/views/homepage/local_widgets/title_widget.dart';
import 'package:to_do_list_riverpod/views/homepage/local_widgets/todoitem_widget.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
      ),
      body: ref.watch(firebaseProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text(err.toString())),
            data: (todos) {
              todolist = todos;
              final newTodoController = useTextEditingController();
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  body: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    children: [
                      const TodoTitle(),
                      TextField(
                        key: addTodoKey,
                        controller: newTodoController,
                        decoration: const InputDecoration(
                          labelText: 'What needs to be done?',
                        ),
                        onSubmitted: (value) {
                          TodoService().createToDo(description: value);
                          ref.read(todoListProvider.notifier);
                          newTodoController.clear();
                        },
                      ),
                      const SizedBox(height: 42),
                      // const Toolbar(),
                      if (todolist.isNotEmpty) const Divider(height: 0),
                      for (var i = 0; i < todolist.length; i++) ...[
                        if (i > 0) const Divider(height: 0),
                        Dismissible(
                          key: ValueKey(todolist[i].id),
                          onDismissed: (_) {
                            TodoService().deleteTodo(todolist[i].id);
                            ref
                                .read(todoListProvider.notifier)
                                .remove(todos[i]);
                          },
                          child: ProviderScope(
                            overrides: [
                              currentTodo.overrideWithValue(todolist[i]),
                            ],
                            child: const TodoItem(),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
