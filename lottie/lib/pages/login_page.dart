import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  String? _error;

  void _login() {
    final username = _nameCtrl.text.trim();
    final password = _passCtrl.text.trim();

    final user = RegisterPage.registeredUsers
        .where((u) => u['name'] == username && u['password'] == password)
        .toList();

    if (user.isNotEmpty) {
      setState(() => _error = null);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() => _error = 'Нэр эсвэл нууц үг буруу байна!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50], // solid background color
      body: IntroductionScreen(
        globalBackgroundColor: Colors.transparent,
        freeze: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        showNextButton: false,
        showDoneButton: false,
        showSkipButton: false,
        pages: [
          PageViewModel(
            titleWidget: Hero(
              tag: 'avatarHero',
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Нэр',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Нууц үг',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Text(
                      _error!,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text(
                        'Нэвтрэх',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),

                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Бүртгүүлэх',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
