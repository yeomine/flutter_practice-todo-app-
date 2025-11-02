import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import '../widgets/todo_input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<TodoItem> _items = [];
  final TextEditingController _controller = TextEditingController();
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    _loadItems(); // 앱 시작 시 데이터 불러오기
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((item) => item.toJson()).toList();
    await prefs.setString('todo_items', jsonEncode(jsonList));
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('todo_items');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      setState(() {
        _items.clear();
        _items.addAll(decoded.map((e) => TodoItem.fromJson(e)));
        _nextId = _items.isEmpty
            ? 0
            : _items.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
      });
    }
  }

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.insert(0, TodoItem(id: _nextId, title: text));
      _nextId++;
    });
    _controller.clear();
    _saveItems(); // 변경 후 저장
  }

  void _toggleDone(int index) {
    setState(() {
      _items[index].done = !_items[index].done;
    });
    _saveItems(); // 변경 후 저장
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    _saveItems(); // 변경 후 저장
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
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16.0),
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
