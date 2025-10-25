import 'package:flutter/material.dart';
import 'screens/todo_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App(Test)',
      theme: ThemeData(colorSchemeSeed: Colors.black),
      home: const TodoHomePage(),
    );
  }
}
