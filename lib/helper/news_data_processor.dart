import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';
import 'package:hacker_news/modules/news_module/repositories/remote/news_data_repo.dart';

import 'client_provider.dart';

class NDataProcessor {
  static Future<List<NewsData>> getMultipleNewsData(List<String> commentIds) async {
    try {
      final requests = commentIds.map((articleId) async {
        return await _getNewsData(articleId);
      }).toList();

      final results = await Future.wait(requests);
      return results;
    } catch (e) {
      throw (e);
    }
  }

  static Future<NewsData> _getNewsData(String id) {
    final client = ClientProvider.getClient(Constants.hackerNBaseUrl);
    try {
      final article = NewsRepo().fetchSingleNewsData(client, id);
      return article;
    } catch (e) {
      throw (e);
    }
  }
}
