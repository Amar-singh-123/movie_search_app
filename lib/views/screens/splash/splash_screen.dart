import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/views/screens/app_screens.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    navigateToNextScreen();
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: "profile",
            child: ProfileCard(radius: 100)),
      ),
    );
  }

  void navigateToNextScreen() {
    Timer(
      Duration(seconds: 2),
      () {
        Get.offAll(() => HomeScreen());
      },
    );
  }
}
