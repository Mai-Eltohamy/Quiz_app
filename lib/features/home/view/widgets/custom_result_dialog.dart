import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_colors.dart';
import 'package:untitled20/core/utils/app_text.dart';

class CustomResultDialog extends StatelessWidget {
  const CustomResultDialog({
    super.key,
    required this.score,
    this.click,
    required this.length,
  });

  final int score;
  final int length;
  final void Function()? click;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            alignment: Alignment(10, 20),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [Text(AppText.result), Text(score.toString())],
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.mainColor),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppText.retest),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
