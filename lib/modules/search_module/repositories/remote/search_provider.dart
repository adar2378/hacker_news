import 'package:dio/dio.dart';
import 'package:hacker_news/modules/search_module/models/search_result.dart';

class SearchProvider {
  Future<SearchResult> search(Dio client, String query) async {
    try {
      final response = await client.get("/search", queryParameters: {
        "query": query,
        "tags": "story",
      });
      final result = SearchResult.fromJson(response.data);
      return result;
    } catch (e) {
      throw (e);
    } finally {
      client.close();
    }
  }
}
