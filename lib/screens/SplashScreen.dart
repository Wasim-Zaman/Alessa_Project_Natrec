import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Core/Animation/Fade_Animation.dart';
import 'Authentication/LoginScreen.dart';

import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () {
      Get.offAll(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
        baseColor: Colors.orange[300]!,
        highlightColor: Colors.white,
        child: Center(
          child: FadeAnimation(
            delay: 1,
            child: Image.asset(
              'assets/alessa.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
