import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_text_style.dart';
import 'package:untitled20/features/home/data/model/answer_model.dart';
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
  List<QuestionModel> questions = [
    QuestionModel(
      title: "What planet is closest to the Sun",
      answers: [
        AnswerModel(title: "Venus"),
        AnswerModel(title: "Mercury"),
        AnswerModel(title: "Mars"),
      ],
      selectedAnswer: null,
      correctAnswer: "Mercury",
    ),
    QuestionModel(
      title: "What gas do humans need to breathe to live",
      answers: [
        AnswerModel(title: "Oxygen"),
        AnswerModel(title: "Nitrogen"),
        AnswerModel(title: "Hydrogen"),
      ],
      selectedAnswer: null,
      correctAnswer: "Oxygen",
    ),
    QuestionModel(
      title: "How many continents are there on Earth",
      answers: [
        AnswerModel(title: "Eight"),
        AnswerModel(title: "Six"),
        AnswerModel(title: "Seven"),
      ],
      selectedAnswer: null,
      correctAnswer: "Seven",
    ),
    QuestionModel(
      title: "What is the largest organ in the human body",
      answers: [
        AnswerModel(title: "Brain"),
        AnswerModel(title: "Skin"),
        AnswerModel(title: "Heart"),
      ],
      selectedAnswer: AnswerModel(title: null),
      correctAnswer: "Skin",
    ),
  ];

  changeSelectedAnswerToNull() {
    for (int i = 0; i < questions.length; i++) {
      questions[i].selectedAnswer = null;
    }
  }

  int score = 0;

  checkScore() {
    for (int i = 0; i < questions.length; i++) {
      if (questions[questionNum].correctAnswer ==
          questions[questionNum].selectedAnswer?.title) {
        score += 1;
      }
    }
  }

  int questionNum = 0;

  plusQuestion() {
    if (questions[questionNum].selectedAnswer == null) {
      return;
    }
    if (questionNum < questions.length - 1) {
      questionNum++;
      setState(() {});
    } else {
      checkScore();
      showDialog(
        context: context,
        builder: (cont) {
          return CustomResultDialog(
            score: score,
            length: questions.length,
            click: () {
              questionNum = 0;
              score = 0;
              changeSelectedAnswerToNull();
              Navigator.pop(context);
              setState(() {});
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45),
        Text(questions[questionNum].title),
        SizedBox(height: 14),
        //cascade operator
        // ممكن اعملها ف صف
        CustomDivider(),
        ...questions[questionNum].answers.map((answers) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(answers.title!),
              //الي هتتلون الي الجروب فاليو بتاعتها زي ال فاليو
              Radio(
                activeColor: AppColors.mainColor,
                value: answers,
                groupValue: questions[questionNum].selectedAnswer,
                onChanged: (v) {
                  questions[questionNum].selectedAnswer = v;
                  setState(() {});
                },
              ),
            ],
          );
        }),
        CustomDivider(),
        SizedBox(height: 14),
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.mainColor,
            ),
            width: 70,
            height: 40,
            child: TextButton(
              onPressed: () {
                plusQuestion();
              },
              child: Text(
                questionNum == questions.length - 1
                    ? AppText.send
                    : AppText.next,
                style: AppTextStyle.secondText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
