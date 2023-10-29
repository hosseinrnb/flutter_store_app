import 'package:dio/dio.dart';
import 'package:flutter_store_app/data/model/comment.dart';
import 'package:flutter_store_app/di/di.dart';
import 'package:flutter_store_app/util/api_exception.dart';
import 'package:flutter_store_app/util/auth_manager.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String comment, String productId);
}

class CommentRemoteDatasource extends ICommentDatasource {
  final Dio _dio = locator.get();
  final String userId = AuthManger.getId();

  @override
  Future<List<Comment>> getComments(String productId) async {
    Map<String, dynamic> qParams = {
      'filter': 'product_id="$productId"',
      'expand': 'user_id',
      'perPage': 200,
    };
    try {
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }

  @override
  Future<void> postComment(String comment, String productId) async {
    try {
      var response = await _dio.post(
        'collections/comment/records',
        data: {
          'text': comment,
          'user_id': userId,
          'product_id': productId,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode,
        ex.response?.data['message'],
      );
    } catch (e) {
      throw ApiException(0, 'unknown error');
    }
  }
}
