import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.mainColor, indent: 50, endIndent: 50);
  }
}
