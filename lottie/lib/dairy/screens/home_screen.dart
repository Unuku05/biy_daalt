import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/diary_provider.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final entries = diaryProvider.entries;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Journal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),

      body: entries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.book_outlined,
                        size: 90, color: Colors.grey.shade400),
                    const SizedBox(height: 20),
                    Text(
                      "No entries yet",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Start journaling your thoughts today!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    title: Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        entry.date.toLocal().toString().split(' ')[0],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              AddEditScreen(entry: entry, index: index),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final tween =
                                Tween(begin: const Offset(0, 0.1), end: Offset.zero)
                                    .chain(CurveTween(curve: Curves.easeOut));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: FadeTransition(
                                  opacity: animation, child: child),
                            );
                          },
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red.shade400,
                      onPressed: () => diaryProvider.deleteEntry(index),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Add Entry"),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => AddEditScreen(),
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
      ),
    );
  }
}
