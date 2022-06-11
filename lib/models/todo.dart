class Todo {
  final int? id;
  final String title;
  final String description;

  Todo({
    this.id,
    required this.title,
    this.description = "",
  });
}
