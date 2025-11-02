class TodoItem {
  final int id;
  String title;
  bool done;

  TodoItem({
    required this.id,
    required this.title,
    this.done = false,
  });

    Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'done': done,
  };

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
    id: json['id'],
    title: json['title'],
    done: json['done'],
  );
}