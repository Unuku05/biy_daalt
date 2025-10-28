import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _flipped = false;
  double _angle = 0;
  late Timer _quoteTimer;
  int _quoteIndex = 0;

  final List<String> quotes = [
    '“Dream big. Code harder.” 💻',
    '“Creativity is intelligence having fun.” 🎨',
    '“Small steps lead to big changes.” 🌱',
    '“Stay curious and keep learning.” 🚀',
  ];

  void _toggleCard() {
    setState(() {
      _flipped = !_flipped;
      _angle += pi; 
    });
  }

  @override
  void initState() {
    super.initState();
    _quoteTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _quoteIndex = (_quoteIndex + 1) % quotes.length;
      });
    });
  }

  @override
  void dispose() {
    _quoteTimer.cancel();
    super.dispose();
  }


  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _toggleCard,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: _angle),
                duration: const Duration(milliseconds: 600),
                builder: (context, double value, _) {
                  final isBack = (value / pi) % 2 < 1;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(value),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          )
                        ],
                        gradient: LinearGradient(
                          colors: isBack
                              ? [Colors.deepPurple, Colors.indigoAccent]
                              : [Colors.orangeAccent, Colors.pinkAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: isBack
                            ? Lottie.asset('assets/lottie/anime.json')
                            : const Icon(Icons.favorite, color: Colors.white, size: 90),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          AnimatedTextKit(
            key: ValueKey(_quoteIndex),
            animatedTexts: [
              FadeAnimatedText(
                quotes[_quoteIndex],
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
            repeatForever: true,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: _toggleCard,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            icon: const Icon(Icons.auto_awesome, color: Colors.white),
            label: const Text(
              'Flip the Magic Card ✨',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildInfoPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatarHero',
              child: CircleAvatar(
                radius: 70,
                backgroundImage: const AssetImage('assets/lottie/avatar.png'),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Сайн байна уу, Unuruu!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Миний хобби:\n🎨 Зураг зурах\n💻 Код бичих\n🎧 Хөгжим сонсох\n📷 Зураг авах\n'
              'Бүтээлч сэтгэлгээг хөгжүүлэхэд тусалдаг!',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Гарах', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCreativePage() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/back.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/creative.json', width: 250, height: 250),
          const SizedBox(height: 20),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Шинэлэг санаа 🚀',
                textStyle: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Бүтээлч ирээдүйг хамтдаа! 💡',
                textStyle: const TextStyle(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
          ),
        ],
      ),
    ),
  );
}

  List<Widget> get _pages => [
        _buildHomePage(),
        _buildInfoPage(),
        _buildCreativePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'),
            fit: BoxFit.cover, // makes the image fill the whole screen
          ),
        ),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: _pages[_selectedIndex],
        ),
      ),

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.yellowAccent,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.auto_awesome, title: 'Creative'),
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
