// flutter에서 화면에 보이는 모든 것 = 위젯
// 버튼, 텍스트, 화면 구조, margin, padding 전부 다 -> 위젯 (html에서 태그로 화면을 구성하는 것과 비슷한 논리)
// Material Design 위젯 사용을 위한 import
import 'package:flutter/material.dart';

// 앱의 시작점(entry point)
void main() {
  // runApp: 루트 위젯을 화면에 붙여주는 역할
  runApp(const MyApp());
}

// MyApp = 우리가 만든 앱을 감싸고 있는 위젯 = 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 루트 위젯에서는 MaterialApp을 리턴
    // Material App =
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: '나의 첫 Flutter 페이지'), // 앱이 켜지면 가장 먼저 보여지는 부분
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  // _MyHomePageState에서 실제 로직 + 상태 관리
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('버튼을 몇 번 눌렀을까용'),
            Text(
              _counter == 0
                  ? '버튼을 눌러보세요!'
                  : _counter < 5
                  ? '조금만 더 눌러보세요!'
                  : '버튼을 많이 누르셨군요!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // 위아래 여백
            ElevatedButton(
              onPressed: _resetCounter,
              child: const Text('카운터 초기화'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.favorite),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
