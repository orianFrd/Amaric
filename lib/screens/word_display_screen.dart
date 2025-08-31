import 'package:flutter/material.dart';
import '../models/word.dart';

class WordDisplayScreen extends StatelessWidget {
  final Word word;

  const WordDisplayScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('מילה')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('עברית: ${word.hebrew}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('אמהרית: ${word.amharic}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text('תעתיק עברי: ${word.hebrewPronunciation}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('תעתיק אמהרי: ${word.amharicPronunciation}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('קטגוריה: ${word.category}', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
