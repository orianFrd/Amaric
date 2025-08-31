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
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _randomWord!.hebrew,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    _randomWord!.amharic,
                    style: TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'הגייה בעברית: ${_randomWord!.hebrewPronunciation}',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'הגייה באמהרית: ${_randomWord!.amharicPronunciation}',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 100.0),
            child: SizedBox(
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: _getRandomWord,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // פינות עגולות יותר
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('מילה אקראית חדשה', style: TextStyle(fontSize: 25)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
