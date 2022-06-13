import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_list_riverpod/models/todo.dart';

final stream = FirebaseFirestore.instance.collection('myTodos').snapshots();
final firebaseProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
  final stream = FirebaseFirestore.instance.collection('myTodos').snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());
});
final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());
bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(() {
    void listener() {
      isFocused.value = node.hasFocus;
    }

    node.addListener(listener);
    return () => node.removeListener(listener);
  }, [node]);

  return isFocused.value;
}
