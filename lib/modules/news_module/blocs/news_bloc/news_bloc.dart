import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/client_provider.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/helper/news_data_processor.dart';
import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';
import 'package:hacker_news/modules/news_module/repositories/remote/news_data_repo.dart';

import 'package:meta/meta.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());
  static NewsRepo _newsRepo = NewsRepo();
  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is NewsFetchTopStroies) {
      yield NewsStateLoading();
      try {
        final client = ClientProvider.getClient(Constants.hackerNBaseUrl);
        // Fetching ids of the top stories
        final articles = await _newsRepo.fetchTopStories(client);
        if (articles == null || articles.length == 0) {
          yield NewsStateData(hasData: false, articles: []);
        } else {
          // Making the network calls for each comments in a seprate isolate
          // so that it doesn't block the main UI thread
          final results = await compute(NDataProcessor.getMultipleNewsData, articles);
          // Converting the NewsData model to ArticleAdapter
          final transformed = DataTransformer.articleToArticleAdapter(results);
          // Sorting according to their time, recent ones stay at top.
          transformed.sort((a, b) => b.time.compareTo(a.time));
          yield NewsStateData(hasData: transformed.length != 0, articles: transformed);
        }
      } catch (e) {
        print(e.toString());
        yield NewsStateError("Failed to process request!");
      }
    }
  }
}
