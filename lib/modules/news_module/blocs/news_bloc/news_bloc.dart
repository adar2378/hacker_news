import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/client_provider.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/adapters/article_adapter.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';
import 'package:hacker_news/modules/news_module/repositories/remote/news_repo.dart';

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
        final articles = await _newsRepo.fetchTopStories(client);
        final requests = articles.map((articleId) {
          return compute(getArticle, articleId);
        }).toList();

        final results = await Future.wait(requests);
        final transformed = DataTransformer.articleToArticleAdapter(results);
        yield NewsStateData(hasData: transformed.length != null, articles: transformed);
      } catch (e) {
        yield NewsStateError("Failed to process request!");
      }
    }
  }

  static Future<Article> getArticle(String id) {
    final client = ClientProvider.getClient(Constants.hackerNBaseUrl);
    try {
      final article = _newsRepo.fetchSingleArticle(client, id);
      return article;
    } catch (e) {
      throw (e);
    }
  }
}
