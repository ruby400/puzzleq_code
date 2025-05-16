import 'package:flutter/material.dart';
import '../data/lesson_data.dart';

class LessonScreen extends StatefulWidget {
  final int startIndex;
  const LessonScreen({super.key, required this.startIndex});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
  }

  void _goToPrevious() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    }
  }

  void _goToNext() {
    if (currentIndex < lessonList.length - 1) {
      setState(() => currentIndex++);
    }
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
                child: Text(
                  lesson.correctSteps.join('\n'),
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '💡 설명 보기:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...lesson.explanations.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('${entry.key} : ${entry.value}'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: _goToPrevious,
                icon: const Icon(Icons.arrow_back),
                label: const Text('이전'),
              ),
              Text('${currentIndex + 1} / ${lessonList.length}'),
              TextButton.icon(
                onPressed: _goToNext,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
