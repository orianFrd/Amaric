import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';
import 'dart:math';

class RandomWordScreen extends StatefulWidget {
  final WordService wordService;

  const RandomWordScreen({super.key, required this.wordService});

  @override
  State<RandomWordScreen> createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen> {
  late Word currentWord;

  @override
  void initState() {
    super.initState();
    currentWord = widget.wordService.getRandomWord();
  }

  void nextWord() {
    Word newWord;
    do {
      newWord = widget.wordService.getRandomWord();
    } while (newWord == currentWord);
    setState(() {
      currentWord = newWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('מילה אקראית')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ExpansionTile(
              title: Text(currentWord.hebrew),
              trailing: const Icon(Icons.arrow_drop_down),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('אמהרית: ${currentWord.amharic}'),
                      Text('ביטוי בעברית: ${currentWord.hebrewPronunciation}'),
                      Text('ביטוי באמהרית: ${currentWord.amharicPronunciation}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextWord,
              child: const Text('מילה הבאה'),
            ),
          ],
        ),
      ),
    );
  }
}
