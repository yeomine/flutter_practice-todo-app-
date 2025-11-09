import 'package:flutter/material.dart';
import 'screens/todo_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App(Firebase 연결 완료!!)',
      theme: ThemeData(colorSchemeSeed: Colors.black),
      home: const TodoHomePage(),
    );
  }
}
