import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/client_provider.dart';
import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/models/article.dart';
import 'package:hacker_news/modules/news_module/repositories/remote/news_data_repo.dart';
import 'package:meta/meta.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is CommentFetch) {
      yield CommentLoading();
      try {
        final stringified = event.commentIds.map((e) => e.toString()).toList();
        final results = await compute(_getComments, stringified);
      } catch (e) {
        print(e.toString());
        yield CommentError("Failed to process request!");
      }
    }
  }

  static Future<List<NewsData>> _getComments(List<String> commentIds) async {
    try {
      final requests = commentIds.map((articleId) async {
        return await _getComment(articleId);
      }).toList();

      final results = await Future.wait(requests);
      return results;
    } catch (e) {
      throw (e);
    }
  }

  static Future<NewsData> _getComment(String id) {
    final client = ClientProvider.getClient(Constants.hackerNBaseUrl);
    try {
      final article = NewsRepo().fetchSingleNewsData(client, id);
      return article;
    } catch (e) {
      throw (e);
    }
  }
}
