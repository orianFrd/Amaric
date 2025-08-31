import 'package:flutter/material.dart';
import '../services/word_service.dart';
import 'word_display_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final WordService wordService;
  const CategoriesScreen({Key? key, required this.wordService}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _categories = widget.wordService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('קטגוריות')),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return ListTile(
            title: Text(category),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WordDisplayScreen(
                    wordService: widget.wordService,
                    category: category,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
