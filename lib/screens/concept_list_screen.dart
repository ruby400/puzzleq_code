import 'package:flutter/material.dart';
import '../data/concept_map.dart';
import '../data/lesson_data.dart';
import 'lesson_screen.dart';

class ConceptListScreen extends StatelessWidget {
  final String level;

  const ConceptListScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final concepts = conceptMap[level] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('$level 개념 목록')),
      body: ListView.builder(
        itemCount: concepts.length,
        itemBuilder: (context, index) {
          final concept = concepts[index];

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
                        (_) => LessonScreen(
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
