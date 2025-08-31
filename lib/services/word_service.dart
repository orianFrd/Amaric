import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word.dart';
import 'dart:math';

class WordService {
  List<Word> _words = [];

  // טוען את הקובץ JSON
  Future<void> loadWords() async {
    final data = await rootBundle.loadString('assets/words.json');
    final jsonResult = json.decode(data) as List<dynamic>;
    _words = jsonResult.map((e) => Word.fromJson(e)).toList();
  }

  // מחזיר את כל הקטגוריות
  List<String> getCategories() {
    final categories = _words.map((w) => w.category).toSet().toList();
    categories.sort();
    return categories;
  }

  // מחזיר את כל המילים בקטגוריה מסוימת
  List<Word> getWordsByCategory(String category) {
    return _words.where((w) => w.category == category).toList();
  }

  // חיפוש מילים לפי מחרוזת בעברית או אמהרית
  List<Word> searchWords(String query) {
    if (query.isEmpty) return [];
    return _words.where((w) =>
    w.hebrew.contains(query) || w.amharic.contains(query)
    ).toList();
  }

  // מחזיר מילה אקראית
  Word getRandomWord() {
    final random = Random();
    return _words[random.nextInt(_words.length)];
  }
}
