import 'package:untitled20/features/home/data/model/answer_model.dart';

class QuestionModel {
  String title;
  List<AnswerModel> answers;
  String correctAnswer;
  AnswerModel? selectedAnswer;

  QuestionModel({
    required this.title,
    required this.answers,
    required this.selectedAnswer,
    required this.correctAnswer,
  });
}
