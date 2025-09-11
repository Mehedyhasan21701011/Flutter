class StoryPart {
  final int id;
  final String title;
  final String text;
  final String imageUrl;

  // Quiz fields (either MCQ or translation)
  final String question;
  final List<String>? options; // null -> translation
  final int? correctIndex; // for MCQ only
  final String? translationKeyword; // for translation check (simple contains)

  StoryPart({
    required this.id,
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.question,
    this.options,
    this.correctIndex,
    this.translationKeyword,
  });

  bool get isTranslation => options == null;
}
