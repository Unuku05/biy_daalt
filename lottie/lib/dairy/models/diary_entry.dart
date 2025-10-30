import 'package:hive/hive.dart';

part 'diary_entry.g.dart'; // <- This is essential

@HiveType(typeId: 0)
class DiaryEntry extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime date;

  DiaryEntry({required this.title, required this.content, required this.date});
}
