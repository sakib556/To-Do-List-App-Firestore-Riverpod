import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_riverpod/models/todo.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class TodoService {
  createToDo({required String description}) {
    String id = _uuid.v4();
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myTodos").doc(id);

    Map<String, String> todoMap = {
      "id": id,
      "description": description,
      "completed": "0"
    };

    documentReference
        .set(todoMap)
        .whenComplete(() => print("Data stored successfully"));
  }

  deleteTodo(String id) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myTodos").doc(id);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
  }

  update({required Todo todo, required String description}) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myTodos").doc(todo.id);
    Map<String, String> todoMap = {
      "description": description,
      "completed": todo.completed ? "1" : "0"
    };
    documentReference
        .update(todoMap)
        .whenComplete(() => print("updated successfully"));
  }

  updateCheckbox({required Todo todo, required bool completed}) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("myTodos").doc(todo.id);
    Map<String, String> todoMap = {
      "description": todo.description,
      "completed": completed ? "1" : "0"
    };
    documentReference
        .update(todoMap)
        .whenComplete(() => print("updated successfully"));
  }
}
