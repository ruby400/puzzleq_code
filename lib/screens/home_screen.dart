import 'package:flutter/material.dart';
import 'level_screen.dart';
import 'custom_concept_screen.dart';
import 'custom_concept_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter 학습 앱')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('단계별 학습 시작하기'),
            subtitle: const Text('기초부터 마스터까지 문제풀이'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LevelScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_box),
            title: const Text('📝 학습 정보 추가 → 문제 생성'),
            subtitle: const Text('Flutter 문서를 복붙해서 직접 학습할 수 있어요'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomConceptScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('📚 내가 입력한 학습 목록 보기'),
            subtitle: const Text('저장된 학습 텍스트에서 문제 다시 생성 가능'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => const CustomConceptListScreen(level: '사용자 생성'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
