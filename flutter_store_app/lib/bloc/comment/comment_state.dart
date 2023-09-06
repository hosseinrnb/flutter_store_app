import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/model/comment.dart';

abstract class CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  CommentResponse(this.response);

  Either<String, List<Comment>> response;
}

class CommentPostLoading extends CommentState {
  CommentPostLoading(this.isLoading);

  final bool isLoading;
}

class CommentPostResponse extends CommentState {
  CommentPostResponse(this.response);

  Either<String, String> response;
}
