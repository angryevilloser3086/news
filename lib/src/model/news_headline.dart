import 'article.dart';

class News {
  String? status;
  int? totalResult;
  List<Article>? articles;

  News(
      {required this.status,
      required this.totalResult,
      required this.articles});
  factory News.fromJson(Map<String, dynamic> json) {
    var arts = (json['articles'] ?? []) as List;
    List<Article> articles = arts.map((e) => Article.fromJson(e)).toList();
    return News(
        status: json['status'],
        totalResult: json['totalResult'],
        articles: articles);
  }
}
