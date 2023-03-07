import 'dart:convert';

import '../models/article_model.dart';
import "package:http/http.dart" as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    // String url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=ce79fe9eb7c74651826b482f58d8b5da";
    var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=ce79fe9eb7c74651826b482f58d8b5da");

    var response = await http.get(url);
    print("res status:  ${response.statusCode}");
    print("Response obj: ${response.body}");

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        print(element);
        // if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            id:element["id"],
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            // publishedAt: element["publishedAt"],
            content: element["content"],
          );
          news.add(articleModel);

      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getCategoryNews(String category) async {
    // String url = "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=ce79fe9eb7c74651826b482f58d8b5da";
    var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=${category}&apiKey=ce79fe9eb7c74651826b482f58d8b5da");

    var response = await http.get(url);
    print("res status:  ${response.statusCode}");
    print("Response obj: ${response.body}");

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        print(element);
        // if (element["urlToImage"] != null && element["description"] != null) {
        ArticleModel articleModel = ArticleModel(
          id:element["id"],
          author: element["author"],
          title: element["title"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          // publishedAt: element["publishedAt"],
          content: element["content"],
        );
        news.add(articleModel);

      });
    }
  }
}
