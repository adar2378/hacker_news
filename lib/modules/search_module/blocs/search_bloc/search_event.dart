part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchFetch extends SearchEvent {
  final String query;

  SearchFetch(this.query);
}
