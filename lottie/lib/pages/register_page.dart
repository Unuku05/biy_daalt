import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static List<Map<String, String>> registeredUsers = [];

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  String? _error;

  void _register() {
    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    final confirm = _confirmCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      setState(() => _error = 'Бүх талбарыг бөглөнө үү!');
      return;
    }

    if (pass != confirm) {
      setState(() => _error = 'Нууц үг таарахгүй байна!');
      return;
    }

    RegisterPage.registeredUsers.add({
      'name': name,
      'email': email,
      'password': pass,
    });

    setState(() => _error = null);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Бүртгэл амжилттай!')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'avatarHero',
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: const AssetImage('assets/avatar.png'),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                    labelText: 'Нэр', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                    labelText: 'Имэйл', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Нууц үг', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Нууц үг давтах',
                    border: OutlineInputBorder()),
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
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Бүртгэл үүсгэх'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
