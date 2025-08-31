import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';

class WordDisplayScreen extends StatefulWidget {
  final WordService wordService;
  final String category;

  const WordDisplayScreen({Key? key, required this.wordService, required this.category}) : super(key: key);

  @override
  State<WordDisplayScreen> createState() => _WordDisplayScreenState();
}

class _WordDisplayScreenState extends State<WordDisplayScreen> {
  List<Word> _words = [];
  final Map<int, bool> _expandedMap = {};

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  void _loadWords() async {
    await widget.wordService.loadWords();
    setState(() {
      _words = widget.wordService.getWordsByCategory(widget.category);
      for (int i = 0; i < _words.length; i++) {
        _expandedMap[i] = false;
      }
    });
  }

  void _toggleExpanded(int index) {
    setState(() {
      _expandedMap[index] = !_expandedMap[index]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_words.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: ListView.builder(
        itemCount: _words.length,
        itemBuilder: (context, index) {
          final word = _words[index];
          final isExpanded = _expandedMap[index]!;

          return Card(
            child: InkWell(
              onTap: () => _toggleExpanded(index),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // המילה הראשית במרכז
                    Center(
                      child: Text(
                        word.hebrew,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // הנתונים הנוספים שיופיעו מתחת במרכז
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('אמהרית: ${word.amharic}', textAlign: TextAlign.center),
                            Text('הגייה בעברית: ${word.hebrewPronunciation}', textAlign: TextAlign.center),
                            Text('הגייה באמהרית: ${word.amharicPronunciation}', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
