// 📄 lib/utils/lesson_storage.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LessonStorageService {
  static const String key = 'saved_lessons';

  static Future<void> saveLessons(List<LessonModel> lessons) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        lessons
            .map(
              (e) => json.encode({
                'id': e.id,
                'title': e.title,
                'concept': e.concept,
                'level': e.level,
                'correctSteps': e.correctSteps,
                'explanations': e.explanations,
              }),
            )
            .toList();
    await prefs.setStringList(key, jsonList);
  }

  static Future<List<LessonModel>> loadLessons() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(key);
    if (jsonList == null) return [];

    return jsonList.map((jsonStr) {
      final data = json.decode(jsonStr);
      return LessonModel(
        id: data['id'],
        title: data['title'],
        concept: data['concept'],
        level: data['level'],
        correctSteps: List<String>.from(data['correctSteps']),
        explanations: Map<String, String>.from(data['explanations']),
      );
    }).toList();
  }
}
