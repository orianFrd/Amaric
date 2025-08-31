import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';

class RandomWordScreen extends StatefulWidget {
  final WordService wordService;
  const RandomWordScreen({Key? key, required this.wordService}) : super(key: key);

  @override
  State<RandomWordScreen> createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen> {
  Word? _randomWord;

  void _getRandomWord() async {
    if (widget.wordService != null) {
      await widget.wordService.loadWords();
      setState(() {
        _randomWord = widget.wordService.getRandomWord();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('מילה אקראית')),
      body: _randomWord == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('עברית: ${_randomWord!.hebrew}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('אמהרית: ${_randomWord!.amharic}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text('הגייה בעברית: ${_randomWord!.hebrewPronunciation}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('הגייה באמהרית: ${_randomWord!.amharicPronunciation}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getRandomWord,
              child: Text('מילה אקראית חדשה'),
            ),
          ],
        ),
      ),
    );
  }
}
