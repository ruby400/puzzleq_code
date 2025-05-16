class CustomConceptModel {
  final String id; // 고유 ID
  final String title; // 루비가 붙인 제목
  final String content; // 루비가 붙여넣은 텍스트
  final DateTime createdAt; // 저장 시각

  CustomConceptModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
  };

  factory CustomConceptModel.fromJson(Map<String, dynamic> json) {
    return CustomConceptModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
