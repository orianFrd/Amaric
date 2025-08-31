import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';

class CategoriesScreen extends StatelessWidget {
  final WordService wordService;

  const CategoriesScreen({super.key, required this.wordService});

  @override
  Widget build(BuildContext context) {
    final categories = wordService.getCategories();
    return Scaffold(
      appBar: AppBar(title: const Text('קטגוריות')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final wordsInCategory = wordService.getWordsByCategory(category);
          return ExpansionTile(
            title: Text(category),
            children: wordsInCategory.map((word) {
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
          );
        },
      ),
    );
  }
}
