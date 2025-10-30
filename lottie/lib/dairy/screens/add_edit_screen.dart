import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';

class AddEditScreen extends StatefulWidget {
  final DiaryEntry? entry;
  final int? index;

  const AddEditScreen({super.key, this.entry, this.index});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _titleController.text = widget.entry!.title;
      _contentController.text = widget.entry!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);

    final entry = DiaryEntry(
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      date: DateTime.now(),
    );

    if (widget.entry == null) {
      diaryProvider.addEntry(entry);
    } else {
      diaryProvider.updateEntry(widget.index!, entry);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Entry' : 'New Entry',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title Field Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Content Field Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      labelText: 'Write your thoughts...',
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    maxLines: 12,
                    style: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveEntry,
        label: Text(isEditing ? 'Update Entry' : 'Save Entry'),
        icon: const Icon(Icons.check_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
