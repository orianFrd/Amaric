import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';

class SearchScreen extends StatefulWidget {
  final WordService wordService;

  const SearchScreen({super.key, required this.wordService});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = widget.wordService.searchWords(query);
    return Scaffold(
      appBar: AppBar(title: const Text('חיפוש מילה')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'הקלד מילה בעברית או באמהרית',
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: results.map((word) {
                return ExpansionTile(
                  title: Text(word.hebrew),
                  trailing: const Icon(Icons.arrow_drop_down),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('אמהרית: ${word.amharic}'),
                          Text('ביטוי בעברית: ${word.hebrewPronunciation}'),
                          Text('ביטוי באמהרית: ${word.amharicPronunciation}'),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
