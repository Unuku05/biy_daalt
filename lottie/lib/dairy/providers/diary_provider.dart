import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';

class DiaryProvider extends ChangeNotifier {
  final Box<DiaryEntry> diaryBox = Hive.box<DiaryEntry>('diary');

  List<DiaryEntry> get entries => diaryBox.values.toList();

  void addEntry(DiaryEntry entry) {
    diaryBox.add(entry);
    notifyListeners();
  }

  void updateEntry(int index, DiaryEntry entry) {
    diaryBox.putAt(index, entry);
    notifyListeners();
  }

  void deleteEntry(int index) {
    diaryBox.deleteAt(index);
    notifyListeners();
  }
}
