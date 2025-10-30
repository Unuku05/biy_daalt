import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

// --- 1. ADD IMPORTS FOR YOUR DIARY ---
import '../dairy/screens/home_screen.dart'; // The screen we modified
import '../dairy/screens/add_edit_screen.dart'; // The screen for adding new entries

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

  // --- 2. ADD A LIST FOR YOUR APPBAR TITLES ---
  final List<String> _pageTitles = [
    'Magic card',
    'Profile',
    'My Journal'
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
                            : const Icon(Icons.favorite,
                                color: Colors.white, size: 90),
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
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
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
                backgroundImage: const AssetImage('assets/avatar.png'),
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
              onPressed: () =>
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false),
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Гарах', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // --- 3. YOU CAN DELETE _buildCreativePage() OR JUST LEAVE IT ---
  // We are no longer using it in the _pages list.

  // --- 4. UPDATE THE _pages LIST ---
  // Replace the 3rd item with your DiaryHomeScreen
  List<Widget> get _pages => [
        _buildHomePage(),
        _buildInfoPage(),
        const DiaryHomeScreen(), // <-- WAS: _buildCreativePage()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // --- 5. MAKE THE TITLE DYNAMIC ---
        title: Text(_pageTitles[_selectedIndex]), // <-- WAS: const Text('Student App')
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
        // --- 6. USE INDEXEDSTACK INSTEAD OF ANIMATEDSWITCHER ---
        // This keeps the state of your tabs (like scroll position) alive.
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),

      // --- 7. ADD THE CONDITIONAL FLOATING ACTION BUTTON ---
      // This button will only appear when the diary tab (index 2) is selected.
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.add),
              label: const Text("Add Entry"),
              onPressed: () {
                // This is the navigation from your old diary app
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const AddEditScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final tween =
                          Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                              .chain(CurveTween(curve: Curves.easeOut));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                  ),
                );
              },
            )
          : null, // Hide the button on other tabs

      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.deepPurple,
        color: Colors.white,
        activeColor: Colors.yellowAccent,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          // --- 8. UPDATE THE 3RD TAB'S ICON AND TITLE ---
          TabItem(icon: Icons.book, title: 'Diary'), // <-- WAS: Icons.auto_awesome
        ],
        initialActiveIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}