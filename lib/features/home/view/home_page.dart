import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_colors.dart';
import 'package:untitled20/core/utils/app_text.dart';
import 'package:untitled20/core/utils/app_text_style.dart';
import 'package:untitled20/core/widgets/custom_app_bar.dart';
import 'package:untitled20/features/home/view/widgets/custom_body_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> questions = [
  //   {
  //     "title": "q1",
  //     "answers": ["a1", "a2", "a3"],
  //     "selectedAnswer": null,
  //     "correctAnswer": "a2",
  //   },
  //   {
  //     "title": "q2",
  //     "answers": ["a4", "a5", "a6"],
  //     "selectedAnswer": null,
  //     "correctAnswer": "a4",
  //   },
  //   {
  //     "title": "q3",
  //     "answers": ["a7", "a8", "a9"],
  //     "selectedAnswer": null,
  //     "correctAnswer": "a9",
  //   },
  // ];

  // int questionNum = 0;
  // plusQuestion() {
  //   if (questionNum < questions.length - 1) {
  //     questionNum++;
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(flexibleSpace: CustomAppBar(name: AppText.mainText)),
      body: CustomBodyHome(),
    );
  }
}
