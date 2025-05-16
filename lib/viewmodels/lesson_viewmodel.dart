import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lesson_model.dart';
import '../data/lesson_data.dart';

class LessonState {
  final int currentIndex;
  final List<String> selectedSteps;
  final bool isCompleted;
  final bool isCorrect;
  final bool showAnswer;

  LessonModel get currentLesson => lessonList[currentIndex];

  LessonState({
    required this.currentIndex,
    required this.selectedSteps,
    required this.isCompleted,
    required this.isCorrect,
    required this.showAnswer,
  });

  LessonState copyWith({
    int? currentIndex,
    List<String>? selectedSteps,
    bool? isCompleted,
    bool? isCorrect,
    bool? showAnswer,
  }) {
    return LessonState(
      currentIndex: currentIndex ?? this.currentIndex,
      selectedSteps: selectedSteps ?? this.selectedSteps,
      isCompleted: isCompleted ?? this.isCompleted,
      isCorrect: isCorrect ?? this.isCorrect,
      showAnswer: showAnswer ?? this.showAnswer,
    );
  }
}

class LessonViewModel extends StateNotifier<LessonState> {
  LessonViewModel()
    : super(
        LessonState(
          currentIndex: 0,
          selectedSteps: [],
          isCompleted: false,
          isCorrect: false,
          showAnswer: false,
        ),
      );

  void selectStep(String step) {
    final updatedSteps = [...state.selectedSteps, step];
    final currentLesson = state.currentLesson;
    final isCompleted =
        updatedSteps.length == currentLesson.correctSteps.length;
    final isCorrect =
        isCompleted &&
        _isCorrectSequence(updatedSteps, currentLesson.correctSteps);

    state = state.copyWith(
      selectedSteps: updatedSteps,
      isCompleted: isCompleted,
      isCorrect: isCorrect,
    );

    if (isCompleted && isCorrect) {
      Future.delayed(const Duration(seconds: 1), nextLesson);
    }
  }

  void toggleAnswerView() {
    state = state.copyWith(showAnswer: !state.showAnswer);
  }

  void nextLesson() {
    if (state.currentIndex + 1 < lessonList.length) {
      state = LessonState(
        currentIndex: state.currentIndex + 1,
        selectedSteps: [],
        isCompleted: false,
        isCorrect: false,
        showAnswer: false,
      );
    }
  }

  void resetCurrentLesson() {
    state = state.copyWith(
      selectedSteps: [],
      isCompleted: false,
      isCorrect: false,
      showAnswer: false,
    );
  }

  static bool _isCorrectSequence(List<String> user, List<String> correct) {
    if (user.length != correct.length) return false;
    for (int i = 0; i < user.length; i++) {
      if (user[i] != correct[i]) return false;
    }
    return true;
  }
}

final lessonProvider = StateNotifierProvider<LessonViewModel, LessonState>((
  ref,
) {
  return LessonViewModel();
});
