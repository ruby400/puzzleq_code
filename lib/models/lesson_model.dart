class LessonModel {
  final String id;
  final String concept; // 개념 이름
  final String level; // 초급/중급/고급/마스터
  String title; // 문제 제목
  final List<String> correctSteps; // 정답 순서
  final Map<String, String> explanations; // 각 항목 설명

  LessonModel({
    required this.id,
    required this.concept,
    required this.level,
    required this.title,
    required this.correctSteps,
    required this.explanations,
  });
}
