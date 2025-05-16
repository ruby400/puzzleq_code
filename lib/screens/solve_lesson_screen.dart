// 📄 lib/screens/solve_lesson_screen.dart
import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import '../data/lesson_data.dart';
import 'lesson_screen.dart';
import 'dart:math';

class SolveLessonScreen extends StatefulWidget {
  final int startIndex;
  const SolveLessonScreen({super.key, required this.startIndex});

  @override
  State<SolveLessonScreen> createState() => _SolveLessonScreenState();
}

class _SolveLessonScreenState extends State<SolveLessonScreen> {
  int currentIndex = 0;
  List<String> userAnswer = [];
  List<Map<String, String>> shuffledOptions = [];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
    _shuffleOptions();
  }

  void _shuffleOptions() {
    final correctSteps = lessonList[currentIndex].correctSteps;
    shuffledOptions = List.generate(
      correctSteps.length,
      (index) => {
        'id': '$index-${Random().nextInt(100000)}',
        'label': correctSteps[index],
      },
    );
    shuffledOptions.shuffle();
  }

  void _selectLine(Map<String, String> item) {
    setState(() {
      userAnswer.add(item['label']!);
      shuffledOptions.removeWhere((element) => element['id'] == item['id']);
    });
  }

  void _removeLine(int index) {
    setState(() {
      shuffledOptions.add({
        'id': '${Random().nextInt(999999)}',
        'label': userAnswer[index],
      });
      userAnswer.removeAt(index);
    });
  }

  void _checkAnswer() {
    final correct = lessonList[currentIndex].correctSteps;
    final isCorrect = _listsMatch(userAnswer, correct);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? '✅ 정답입니다!' : '❌ 틀렸어요 😢'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  bool _listsMatch(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _goToExplanation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LessonScreen(startIndex: currentIndex)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lesson = lessonList[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('[${lesson.level}] ${lesson.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '조립된 문장:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Wrap(
                  spacing: 6,
                  children: List.generate(
                    userAnswer.length,
                    (index) => InputChip(
                      label: Text(userAnswer[index]),
                      onDeleted: () => _removeLine(index),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('다음에서 올 코드를 선택하세요:'),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    shuffledOptions.map((item) {
                      return ElevatedButton(
                        onPressed: () => _selectLine(item),
                        child: Text(item['label']!),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _checkAnswer,
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('정답 확인'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _goToExplanation,
                    icon: const Icon(Icons.remove_red_eye),
                    label: const Text('정답 보기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
