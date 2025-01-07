import 'package:flutter/material.dart';
import 'package:win_by_quiz/screens/welcome_screen.dart';

class WinByQuizApp extends StatelessWidget {
  const WinByQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Quizzer'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey.shade800,
          foregroundColor: Colors.white,
        ),
        body: WelcomeScreen(),
      ),
    );
  }
}
