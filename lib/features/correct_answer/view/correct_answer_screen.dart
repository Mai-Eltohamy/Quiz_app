import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_colors.dart';
import 'package:untitled20/core/utils/app_text.dart';
import 'package:untitled20/features/home/data/model/question_model.dart';

class CorrectAnswerScreen extends StatelessWidget {
  final List<QuestionModel> questions;

  const CorrectAnswerScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.check,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return _buildQuestionCard(questions[index], index);
        },
      ),
    );
  }

  Widget _buildQuestionCard(QuestionModel question, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(index, question.title),
            const SizedBox(height: 12),
            ...question.answers.map(
              (answer) => _buildAnswerItem(answer, question),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionHeader(int index, String title) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerItem(String answer, QuestionModel question) {
    bool isCorrect = answer == question.correctAnswer;
    bool isSelected = answer == question.selectedAnswer;

    Color? backgroundColor;
    Color? borderColor;
    Color? textColor;

    if (isCorrect) {
      backgroundColor = Colors.green.withOpacity(0.1);
      borderColor = Colors.green;
      textColor = Colors.green;
    } else if (isSelected && !isCorrect) {
      backgroundColor = Colors.red.withOpacity(0.1);
      borderColor = Colors.red;
      textColor = Colors.red;
    } else {
      backgroundColor = Colors.grey.withOpacity(0.05);
      borderColor = Colors.grey[300];
      textColor = Colors.black;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor!),
      ),
      child: Row(
        children: [
          if (isCorrect || (isSelected && !isCorrect))
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? Colors.green : Colors.red,
              size: 20,
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              answer,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
                fontWeight:
                    isCorrect || (isSelected && !isCorrect)
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
          ),
          if (isCorrect)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Correct',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
