import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_text_style.dart';
import 'package:untitled20/features/home/data/model/question_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text.dart';
import 'custom_divider.dart';
import 'custom_result_dialog.dart';

class CustomBodyHome extends StatefulWidget {
  const CustomBodyHome({super.key});

  @override
  State<CustomBodyHome> createState() => _CustomBodyHomeState();
}

class _CustomBodyHomeState extends State<CustomBodyHome> {
  List<QuestionModel> _questions = [];
  int _questionNum = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _initializeQuestions();
  }

  void _initializeQuestions() {
    _questions = [
      QuestionModel(
        title: "What planet is closest to the Sun",
        answers: ["Venus", "Mercury", "Mars"],
        selectedAnswer: null,
        correctAnswer: "Mercury",
        id: "1",
      ),
      QuestionModel(
        title: "What gas do humans need to breathe to live",
        answers: ["Oxygen", "Nitrogen", "Hydrogen"],
        selectedAnswer: null,
        correctAnswer: "Oxygen",
        id: "2",
      ),
      QuestionModel(
        title: "How many continents are there on Earth",
        answers: ["Eight", "Six", "Seven"],
        selectedAnswer: null,
        correctAnswer: "Seven",
        id: "3",
      ),
      QuestionModel(
        title: "What is the largest organ in the human body",
        answers: ["Brain", "Skin", "Heart"],
        selectedAnswer: null,
        correctAnswer: "Skin",
        id: "4",
      ),
    ];
  }

  void _resetQuiz() {
    setState(() {
      _initializeQuestions();
      _questionNum = 0;
      _score = 0;
    });
  }

  void _calculateFinalScore() {
    int tempScore = 0;
    for (var question in _questions) {
      if (question.selectedAnswer == question.correctAnswer) {
        tempScore += 10;
      }
    }
    setState(() {
      _score = tempScore;
    });
  }

  void _goToNextQuestion() {
    if (_questions[_questionNum].selectedAnswer == null) {
      _showSnackBar("Please choose one answer");
      return;
    }

    if (_questionNum < _questions.length - 1) {
      setState(() {
        _questionNum++;
      });
    } else {
      _calculateFinalScore();
      _showResultDialog();
    }
  }

  void _goToPreviousQuestion() {
    if (_questionNum > 0) {
      setState(() {
        _questionNum--;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomResultDialog(
          questions: _questions,
          score: _score,
          length: _questions.length,
          onRetestPressed: () {
            Navigator.pop(context);
            _resetQuiz();
          },
        );
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LinearProgressIndicator(
        value: (_questionNum + 1) / _questions.length,
        backgroundColor: AppColors.mainColor.withOpacity(0.2),
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainColor),
        minHeight: 8,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildQuestionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Question ${_questionNum + 1}/${_questions.length}",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Score: $_score",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        _questions[_questionNum].title,
        style: AppTextStyle.secondText.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnswerOption(String answer) {
    bool isSelected = _questions[_questionNum].selectedAnswer == answer;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _questions[_questionNum].selectedAnswer = answer;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.mainColor.withOpacity(0.1)
                    : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.mainColor : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? AppColors.mainColor : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              Radio(
                activeColor: AppColors.mainColor,
                value: answer,
                groupValue: _questions[_questionNum].selectedAnswer,
                onChanged: (v) {
                  setState(() {
                    _questions[_questionNum].selectedAnswer = v;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _goToNextQuestion,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            _questionNum == _questions.length - 1 ? AppText.send : AppText.next,
            style: AppTextStyle.secondText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreviousButton() {
    if (_questionNum == 0) return const SizedBox.shrink();

    return TextButton(
      onPressed: _goToPreviousQuestion,
      child: const Text(
        "Previous",
        style: TextStyle(color: AppColors.white, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _buildProgressIndicator(),
        const SizedBox(height: 10),
        _buildQuestionHeader(),
        const SizedBox(height: 10),
        _buildQuestionTitle(),
        const SizedBox(height: 10),
        const CustomDivider(),
        ..._questions[_questionNum].answers.map(_buildAnswerOption).toList(),
        const CustomDivider(),
        const SizedBox(height: 20),
        _buildNextButton(),
        const SizedBox(height: 10),
        _buildPreviousButton(),
      ],
    );
  }
}
