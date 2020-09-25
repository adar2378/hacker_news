part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentError extends CommentState {
  final String errorMessage;

  CommentError(this.errorMessage);
}

class CommentData extends CommentState {
  final bool hasData;
  final List<CommentAdapter> comments;

  CommentData(this.hasData, this.comments);
}
