class Article {
  final int id;
  final String title;
  final String excerpt;
  final String category;
  final String imageUrl;
  final String readTime;
  final String date;
  final bool isFeatured;

  Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.category,
    required this.imageUrl,
    required this.readTime,
    required this.date,
    this.isFeatured = false,
  });
}