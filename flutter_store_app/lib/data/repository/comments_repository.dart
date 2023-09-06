import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/data/datasource/comment_datasource.dart';
import 'package:flutter_store_app/data/model/comment.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/util/api_exception.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String comment, String productId);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String comment, String productId) async {
    try {
      var response = await _datasource.postComment(comment, productId);
      return right('نظر شما با موفقیت اضافه شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'unknown error!');
    }
  }
}
