import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import '../widgets/todo_input_field.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<TodoItem> _items = [];
  final TextEditingController _controller = TextEditingController();
  int _nextId = 0;

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.insert(0, TodoItem(id: _nextId, title: text));
      _nextId++;
    });
    _controller.clear();
  }

  void _toggleDone(int index) {
    setState(() {
      _items[index].done = !_items[index].done;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Column(
        children: [
          TodoInputField(controller: _controller, onAdd: _addItem),
          Expanded(
            child: _items.isEmpty
                ? const Center(child: Text('할 일을 추가해보세요!'))
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Dismissible(
                        key: ValueKey(item.title + index.toString()),
                        onDismissed: (_) => _removeItem(index),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            item.title,
                            style: TextStyle(
                              decoration: item.done
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          value: item.done,
                          onChanged: (_) => _toggleDone(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
