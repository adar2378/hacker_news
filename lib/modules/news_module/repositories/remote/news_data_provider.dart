import 'package:dio/dio.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';

class NewsProvider {
  Future<List<String>> fetchTopStories(Dio client) async {
    try {
      final response = await client.get("/v0/topstories.json", queryParameters: {
        "orderBy": "\"\$key\"",
        "limitToFirst": "25",
        "print": "pretty",
      });
      final results = List<String>.from(response.data.map((x) => x.toString()));
      return results;
    } catch (e) {
      throw (e);
    } finally {
      client.close();
    }
  }

  Future<NewsData> fetchSingleNewData(Dio client, String articleId) async {
    try {
      final response = await client.get("/v0/item/$articleId.json?print=pretty");
      final newsData = NewsData.fromJson(response.data);
      return newsData;
    } catch (e) {
      throw (e);
    } finally {
      client.close();
    }
  }
}
