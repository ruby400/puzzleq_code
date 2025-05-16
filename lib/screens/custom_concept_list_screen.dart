import 'package:flutter/material.dart';
import '../data/lesson_data.dart';
import 'solve_lesson_screen.dart';

class CustomConceptListScreen extends StatelessWidget {
  final String level;

  const CustomConceptListScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    // 🔥 이 레벨에서 등록된 모든 개념을 추출
    final levelConcepts =
        lessonList
            .where((lesson) => lesson.level == level)
            .map((lesson) => lesson.concept)
            .toSet()
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('$level 개념 목록')),
      body: ListView.builder(
        itemCount: levelConcepts.length,
        itemBuilder: (context, index) {
          final concept = levelConcepts[index];

          final conceptLessons =
              lessonList
                  .where(
                    (lesson) =>
                        lesson.level == level && lesson.concept == concept,
                  )
                  .toList();

          return ListTile(
            title: Text(concept),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (conceptLessons.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => SolveLessonScreen(
                          startIndex: lessonList.indexOf(conceptLessons.first),
                        ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('해당 개념에 대한 문제가 아직 없습니다.'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
