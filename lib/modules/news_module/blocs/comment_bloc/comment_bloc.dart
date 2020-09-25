import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/client_provider.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/helper/news_data_processor.dart';
import 'package:hacker_news/misc/constants.dart';
import 'package:hacker_news/modules/news_module/adapters/comment_adapter.dart';
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
        if (event.commentIds == null || event.commentIds.length == 0) {
          yield CommentData(false, []);
        } else {
          final stringified = event.commentIds.map((e) => e.toString()).toList();
          final results = await compute(NDataProcessor.getMultipleNewsData, stringified);
          final comments = DataTransformer.commentToCommentAdapter(results);
          comments.sort((a, b) => b.time.compareTo(a.time));
          yield CommentData(comments.length != 0, comments);
        }
      } catch (e) {
        print(e.toString());
        yield CommentError("Failed to process request!");
      }
    }
  }
}
