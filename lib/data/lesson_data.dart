// 📄 lib/data/lesson_data.dart
import '../models/lesson_model.dart';
import '../utils/lesson_storage.dart';

List<LessonModel> lessonList = [];

Future<void> loadLessonsFromStorage() async {
  final saved = await LessonStorageService.loadLessons();

  if (saved.isNotEmpty) {
    lessonList = saved;
  } else {
    // 최초 실행 시 기본 예시 문제 저장
    lessonList = [
      LessonModel(
        id: 'q1',
        concept: 'main 함수',
        level: '초급',
        title: '앱 시작 구조 조립',
        correctSteps: [
          'void',
          'main',
          '(',
          ')',
          '{',
          'runApp',
          '(',
          'MyApp',
          '(',
          ')',
          ')',
          ';',
          '}',
        ],
        explanations: {
          'void': '리턴값이 없음을 나타냅니다.',
          'main': '앱의 진입점 함수입니다.',
          'runApp': 'Flutter 앱을 실행하는 함수입니다.',
          'MyApp': '사용자 정의 위젯입니다.',
        },
      ),
    ];
    await LessonStorageService.saveLessons(lessonList);
  }
}
