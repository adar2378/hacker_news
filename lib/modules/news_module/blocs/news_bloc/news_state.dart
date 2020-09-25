part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsStateLoading extends NewsState {}

class NewsStateError extends NewsState {
  final String message;

  NewsStateError(this.message);
}

class NewsStateData extends NewsState {
  final bool hasData;
  final List<ArticleAdapter> articles;

  NewsStateData({@required this.hasData, @required this.articles});
}

class NewsStateHasSingleArticle extends NewsState {
  final ArticleAdapter article;

  NewsStateHasSingleArticle(this.article);
}
