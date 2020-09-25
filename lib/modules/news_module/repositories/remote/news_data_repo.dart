import 'package:dio/dio.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';

import 'news_data_provider.dart';

class NewsRepo {
  NewsProvider _newsProvider;
  NewsRepo() {
    _newsProvider = NewsProvider();
  }

  /// Fetches top stories
  Future<List<String>> fetchTopStories(Dio client) => _newsProvider.fetchTopStories(client);

  /// Fetches a single article
  Future<NewsData> fetchSingleNewsData(Dio client, String articleId) =>
      _newsProvider.fetchSingleNewData(client, articleId);
}
