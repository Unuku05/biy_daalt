import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.deepPurple[50],
      showNextButton: true,
      showSkipButton: true,
      showDoneButton: true,
      next: const Icon(Icons.arrow_forward),
      skip: const Text("Skip"),
      done: const Text("Login", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        // Navigate to Login Page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginPage()));
      },
      pages: [
        PageViewModel(
          title: "Сайн уу!",
          body: "Энэ бол миний оюутны аппын танилцуулга.",
          image: Center(
            child: Image.asset('assets/avatar.png', width: 150),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
        PageViewModel(
          title: "Миний хобби",
          body: "Зураг зурах, код бичих, хөгжим сонсох",
          image: Center(
            child: Icon(Icons.brush, size: 150, color: Colors.deepPurple),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
        PageViewModel(
          title: "Бүтээлч бай",
          body: "Шинэлэг санаа, код, дизайн бүгд энд!",
          image: Center(
            child: Icon(Icons.lightbulb, size: 150, color: Colors.amber),
          ),
          decoration: const PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            bodyTextStyle: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
