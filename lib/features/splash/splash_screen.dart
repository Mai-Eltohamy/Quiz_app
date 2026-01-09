import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:untitled20/core/utils/app_images.dart';
import 'package:untitled20/features/home/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) {
            return HomePage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(AppImages.up, height: 252, width: 265),
          ),
          Spacer(),
          Center(
            child: BounceInDown(
              child: Image.asset(AppImages.logo, height: 59, width: 231),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(AppImages.down, height: 252, width: 265),
          ),
        ],
      ),
    );
  }
}
