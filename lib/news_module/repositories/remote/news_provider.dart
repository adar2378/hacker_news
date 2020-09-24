import 'package:dio/dio.dart';

import 'package:hacker_news/news_module/models/article.dart';

class NewsProvider {
  Future<List<String>> fetchTopStories(Dio client) async {
    try {
      final response = await client.get("/v0/topstories/orderBy=\"\$key\"&limitToFirst=25");
      final results = List<String>.from(response.data.map((x) => x.toString()));
      return results;
    } catch (e) {
      throw (e);
    } finally {
      client.close();
    }
  }

  Future<Article> fetchSingleArticle(Dio client, String articleId) async {
    try {
      final response = await client.get("/v0/item/$articleId.json?print=pretty");
      final article = Article.fromJson(response.data);
      return article;
    } catch (e) {
      throw (e);
    } finally {
      client.close();
    }
  }
}
