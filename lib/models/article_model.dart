class ArticleModel {
  String? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  // DateTime publishedAt;
  String? content;

  ArticleModel({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    // required this.publishedAt,
    required this.content,
  });
}
