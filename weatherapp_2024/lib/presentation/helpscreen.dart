import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../datasource/localStorage/button_press_detector.dart'; // Import the utility
import './homepagescreen.dart'; // Import the Homepage screen

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
    _checkSkipStatus();
    TimedNavigation();
  }

  Future<void> _checkSkipStatus() async {
    bool skipClicked = await SkipButtonUtil.hasSkipButtonPressed();
    if (skipClicked) {
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  void _onSkipPressed() {
    SkipButtonUtil.setSkipButtonPressed(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> TimedNavigation() async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Bg1.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Lottie Asset
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                child: Lottie.asset(
                  'assets/lottie/Animation1.json',
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),
              // Text View
              const Text(
                'We Show Weather For\nYou\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Button
              ElevatedButton(
                onPressed: _onSkipPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
