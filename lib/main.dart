import 'package:flutter/material.dart';
import 'screens/random_word_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/search_screen.dart';
import 'services/word_service.dart';
import 'widgets/card_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final WordService? wordService;

  const MyApp({super.key, this.wordService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final WordService wordService;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    wordService = widget.wordService ?? WordService();
    wordService.loadWords().then((_) {
      setState(() {
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      title: 'Amharic Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // כאן הוספנו את התמיכה ב-RTL
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: HomePage(wordService: wordService),
    );
  }
}

class HomePage extends StatelessWidget {
  final WordService wordService;

  const HomePage({super.key, required this.wordService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amharic Translator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardWidget(
              title: 'קטגוריות',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoriesScreen(wordService: wordService),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CardWidget(
              title: 'חיפוש מילה',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchScreen(wordService: wordService),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            CardWidget(
              title: 'מילה אקראית',
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RandomWordScreen(wordService: wordService),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
