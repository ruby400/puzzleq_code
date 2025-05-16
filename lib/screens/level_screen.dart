import 'package:flutter/material.dart';
import 'concept_list_screen.dart';

class LevelScreen extends StatelessWidget {
  LevelScreen({super.key});

  final List<String> levels = ['기초', '초급', '중급', '고급', '마스터']; // ✅ 기초 포함
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('단계 선택')),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return ListTile(
            title: Text(level),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConceptListScreen(level: level),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
