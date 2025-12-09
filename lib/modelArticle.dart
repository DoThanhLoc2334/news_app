class ModelArticle {
  final String title;
  final String description;
  final String imageUrl;
  final String id;

  ModelArticle({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.id,
  });

  factory ModelArticle.fromJson(Map<String, dynamic> json){
    return ModelArticle(
        title: json['title'] ?? 'No title',
        description: json['description'] ?? '',
        imageUrl: json['urlToImage'] ?? json['image'] ?? '',
        id: json['id']?.toString() ?? (json['url'] ?? '').toString(),
    );
  }
}
