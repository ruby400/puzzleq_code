// 📄 main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash_screen.dart';
import 'data/lesson_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadLessonsFromStorage(); // 저장된 문제 불러오기
  await dotenv.load();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '루비의 플러터 앱',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}
