part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class CommentFetch extends CommentEvent {
  final List<int> commentIds;

  CommentFetch(this.commentIds);
}
