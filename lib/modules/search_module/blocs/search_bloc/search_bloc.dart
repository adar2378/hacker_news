import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/client_provider.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/helper/news_data_processor.dart';
import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/search_module/repositories/remote/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchFetch) {
      yield SearchLoading();

      try {
        final client = ClientProvider.getClient(Constants.algoliaBaseUrl);
        final searchResult = await SearchRepo().search(client, event.query);
        if (searchResult.hits != null && searchResult.hits.length > 0) {
          final results =
              await compute(NDataProcessor.getMultipleNewsData, searchResult.hits.map((e) => e.objectId).toList());
          final stories = DataTransformer.articleToArticleAdapter(results);
          stories.sort((a, b) => b.time.compareTo(a.time));
          yield SearchData(stories.length != 0, stories);
        } else {
          yield SearchData(false, []);
        }
      } catch (e) {
        if (e is DioError) {
          if (e.response.statusCode == 404) {
            yield SearchError("No results found!");
          } else if (e.response.statusCode == 500) {
            yield SearchError("Having issues with the server!");
          } else {
            yield SearchError("Failed to process request");
          }
        } else
          yield SearchError("Failed to process request");
      }
    }
  }
}
