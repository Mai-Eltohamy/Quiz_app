class QuestionModel {
  final String id;
  final String title;
  final List<String> answers;
  final String correctAnswer;
  String? selectedAnswer;

  QuestionModel({
    required this.id,
    required this.title,
    required this.answers,
    required this.correctAnswer,
    this.selectedAnswer, // nullable
  });

  // دالة نسخ مع تحديث الإجابة المختارة
  QuestionModel copyWith({String? selectedAnswer}) {
    return QuestionModel(
      id: id,
      title: title,
      answers: answers,
      correctAnswer: correctAnswer,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}
