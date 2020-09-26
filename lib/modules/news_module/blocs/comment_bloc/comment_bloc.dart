import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hacker_news/helper/data_transformer.dart';
import 'package:hacker_news/helper/news_data_processor.dart';
import 'package:hacker_news/modules/news_module/adapters/comment_adapter.dart';
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
          // If no comments then returning empty data
          yield CommentData(false, []);
        } else {
          // Converting List<int> to List<String>
          final stringified = event.commentIds.map((e) => e.toString()).toList();
          // Making the network calls for each comments in a seprate isolate
          // so that it doesn't block the main UI thread
          final results = await compute(NDataProcessor.getMultipleNewsData, stringified);
          // Converting the NewsData model to CommentAdapter
          final comments = DataTransformer.commentToCommentAdapter(results);
          // Sorting according to their time, recent ones stay at top.
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
