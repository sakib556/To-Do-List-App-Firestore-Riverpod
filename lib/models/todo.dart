class Todo {
  Todo({required this.id, required this.description, this.completed = false});

  final String id;
  final String description;
  final bool completed;

  // @override
  // String toString() {
  //   return 'Todo(description: $description, completed: $completed)';
  // }
  Todo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        description = json['description'],
        completed = json['completed'].toString().contains("1") ? true : false;

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'completed': completed,
      };
}

/// An object that controls a list of [Todo].
