import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word.dart';
import 'dart:math';

class WordService {
  List<Word> _words = [];

  // טוען את כל הקבצים שב-assets/words
  Future<void> loadWords() async {
    final categories = [
      'agriculture', 'air_transport', 'animals', 'art', 'banking', 'body',
      'city_places', 'clothing', 'colors', 'commerce', 'daily_life', 'days',
      'drinks', 'economy', 'education', 'electronics', 'emotions', 'family',
      'fast_food', 'food', 'furniture', 'greetings', 'health', 'holidays',
      'home', 'law', 'media', 'medicine', 'music', 'nature', 'numbers',
      'people', 'pets', 'politics', 'private_transport', 'professions',
      'public_transport', 'religion', 'restaurants', 'rooms', 'science',
      'seasons', 'shopping', 'sports', 'technology', 'time', 'tools',
      'transportation', 'village', 'weather'
    ];

    List<Word> loadedWords = [];
    for (var cat in categories) {
      try {
        final data = await rootBundle.loadString('assets/words/$cat.json');
        final jsonResult = json.decode(data) as List<dynamic>;
        loadedWords.addAll(jsonResult.map((e) => Word.fromJson(e)).toList());
      } catch (e) {
        print('Error loading $cat.json: $e');
      }
    }

    _words = loadedWords;
  }

  List<String> getCategories() {
    final categories = _words.map((w) => w.category).toSet().toList();
    categories.sort();
    return categories;
  }

  List<Word> getWordsByCategory(String category) {
    return _words.where((w) => w.category == category).toList();
  }

  List<Word> searchWords(String query) {
    if (query.isEmpty) return [];
    return _words.where((w) =>
    w.hebrew.contains(query) || w.amharic.contains(query)
    ).toList();
  }

  Word getRandomWord() {
    final random = Random();
    return _words[random.nextInt(_words.length)];
  }
}
