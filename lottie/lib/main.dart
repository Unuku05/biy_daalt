import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/intro_page.dart';

// --- 1. ADD ALL THESE IMPORTS ---
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart'; // For Hive.initFlutter()
import 'dairy/providers/diary_provider.dart';
import 'dairy/models/diary_entry.dart'; // We need this to register the adapter

// --- 2. UPDATE YOUR main() FUNCTION TO BE async ---
void main() async {
  // --- 3. ADD HIVE SETUP ---
  WidgetsFlutterBinding.ensureInitialized(); // Required before async calls
  await Hive.initFlutter();
  
  // You MUST register your model's adapter (check your diary app's old main.dart)
  Hive.registerAdapter(DiaryEntryAdapter()); // <-- IMPORTANT!
  
  await Hive.openBox<DiaryEntry>('diary');
  // --- END OF HIVE SETUP ---

  runApp(
    ChangeNotifierProvider(
      create: (context) => DiaryProvider(),
      child: const MyApp(), 
    ),
  );
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