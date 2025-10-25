import 'package:flutter/material.dart';

class TodoInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const TodoInputField({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: '할 일을 입력하세요.',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => onAdd(),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAdd,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}