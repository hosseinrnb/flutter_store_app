abstract class CommentEvent {}

class CommentInitilizeEvent extends CommentEvent {
  CommentInitilizeEvent(this.productId);

  final String productId;
}

class CommentPostEvent extends CommentEvent {
  CommentPostEvent(this.productId, this.comment);

  final String productId;
  final String comment;
}
