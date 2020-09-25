part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}

class SearchData extends SearchState {
  final bool hasData;
  final List<ArticleAdapter> articles;

  SearchData(this.hasData, this.articles);
}
