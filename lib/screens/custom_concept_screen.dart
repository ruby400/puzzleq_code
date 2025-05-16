import 'package:flutter/material.dart';
import '../utils/gpt_service.dart';
import '../models/lesson_model.dart';
import 'package:uuid/uuid.dart';
import '../data/lesson_data.dart';

class CustomConceptScreen extends StatefulWidget {
  const CustomConceptScreen({super.key});

  @override
  State<CustomConceptScreen> createState() => _CustomConceptScreenState();
}

class _CustomConceptScreenState extends State<CustomConceptScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;

  Future<void> _generateLesson() async {
    final content = _contentController.text.trim();
    final title = _titleController.text.trim();
    if (content.isEmpty || title.isEmpty) return;

    setState(() => _isLoading = true);
    final result = await GptService.generateLesson(content);
    if (!mounted) return;

    if (result != null) {
      final newLesson = LessonModel(
        id: result['id'] ?? const Uuid().v4(),
        concept: title,
        level: '사용자 생성',
        title: result['title'] ?? 'AI 생성 문제',
        correctSteps: List<String>.from(result['correctSteps'] ?? []),
        explanations: Map<String, String>.from(result['explanations'] ?? {}),
      );
      lessonList.add(newLesson);

      debugPrint('🟢 문제 생성됨: ${newLesson.title}, 레벨: ${newLesson.level}');
      debugPrint('🟢 전체 문제 수: ${lessonList.length}');

      setState(() {}); // 화면 갱신
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('문제가 생성되었습니다!')));
      Navigator.pop(context); // 목록화면으로 돌아감
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('문제 생성 실패 😢')));
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI 문제 생성하기')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: '플러터 개념을 붙여넣기 하세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
                  onPressed: _generateLesson,
                  icon: const Icon(Icons.auto_fix_high),
                  label: const Text('문제 생성 요청'),
                ),
          ],
        ),
      ),
    );
  }
}
