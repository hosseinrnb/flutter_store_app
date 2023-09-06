import 'package:bloc/bloc.dart';
import 'package:flutter_store_app/bloc/comment/comment_event.dart';
import 'package:flutter_store_app/bloc/comment/comment_state.dart';
import 'package:flutter_store_app/data/repository/comments_repository.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  ICommentRepository repository;

  CommentBloc(this.repository) : super(CommentLoading()) {
    on<CommentInitilizeEvent>((event, emit) async {
      final response = await repository.getComments(event.productId);
      emit(CommentResponse(response));
    });

    on<CommentPostEvent>((event, emit) async {
      emit(CommentPostLoading(true));
      await repository.postComment(event.comment, event.productId);
      final response = await repository.getComments(event.productId);
      emit(CommentResponse(response));
    });
  }
}
