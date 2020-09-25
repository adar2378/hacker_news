import 'package:dio/dio.dart';
import 'package:hacker_news/modules/search_module/models/search_result.dart';
import 'package:hacker_news/modules/search_module/repositories/remote/search_provider.dart';

class SearchRepo {
  final SearchProvider _searchProvider = SearchProvider();

  Future<SearchResult> search(Dio client, String query) => _searchProvider.search(client, query);
}
