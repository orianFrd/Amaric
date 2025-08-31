class Word {
  final String hebrew;
  final String amharic;
  final String hebrewPronunciation;
  final String amharicPronunciation;
  final String category;

  Word({
    required this.hebrew,
    required this.amharic,
    required this.hebrewPronunciation,
    required this.amharicPronunciation,
    required this.category,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      hebrew: json['hebrew'],
      amharic: json['amharic'],
      hebrewPronunciation: json['hebrew_pronunciation'],
      amharicPronunciation: json['amharic_pronunciation'],
      category: json['category'],
    );
  }
}
