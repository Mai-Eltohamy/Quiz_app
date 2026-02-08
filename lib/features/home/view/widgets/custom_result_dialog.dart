import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_colors.dart';
import 'package:untitled20/core/utils/app_text.dart';
import 'package:untitled20/features/correct_answer/view/correct_answer_screen.dart';
import 'package:untitled20/features/home/data/model/question_model.dart';

class CustomResultDialog extends StatelessWidget {
  const CustomResultDialog({
    super.key,
    required this.score,
    required this.onRetestPressed,
    required this.length,
    required this.questions,
  });

  final List<QuestionModel> questions;
  final int score;
  final int length;
  final VoidCallback onRetestPressed;

  double get _percentage => (score / (length * 10)) * 100;

  String get _resultMessage {
    if (_percentage >= 80) return 'ممتاز!';
    if (_percentage >= 60) return 'جيد جداً';
    if (_percentage >= 50) return 'مقبول';
    return 'يحتاج تحسين';
  }

  void _navigateToReviewScreen(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CorrectAnswerScreen(questions: questions),
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppText.result,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildScoreCircle() {
    return Container(
      width: 120,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.mainColor.withOpacity(0.8), AppColors.mainColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$score/${length * 10}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${_percentage.round()}%',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultMessage() {
    return Text(
      _resultMessage,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: _percentage >= 50 ? Colors.green : Colors.orange,
      ),
    );
  }

  Widget _buildReviewButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          _navigateToReviewScreen(context);
        },
        icon: const Icon(Icons.remove_red_eye_outlined, size: 20),
        label: const Text('راجع إجاباتك', style: TextStyle(fontSize: 16)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: AppColors.mainColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildRetestButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onRetestPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          AppText.retest,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogHeader(context),
            const SizedBox(height: 20),
            _buildScoreCircle(),
            const SizedBox(height: 20),
            _buildResultMessage(),
            const SizedBox(height: 8),
            Text(
              'الإجابات الصحيحة: ${(score / 10).toInt()} من $length',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            _buildReviewButton(context),
            const SizedBox(height: 12),
            _buildRetestButton(),
          ],
        ),
      ),
    );
  }
}
