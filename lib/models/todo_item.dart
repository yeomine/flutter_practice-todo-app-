class TodoItem {
  final int id;
  String title;
  bool done;

  TodoItem({
    required this.id,
    required this.title,
    this.done = false,
  });
}