part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class NewsFetchTopStroies extends NewsEvent {}

class NewsFetchSingleArticle extends NewsEvent {
  final String articleId;

  NewsFetchSingleArticle(this.articleId);
}
