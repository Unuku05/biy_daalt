import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
import 'pages/login_page.dart';
// import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/intro_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(), 
      },
    );
  }
}

