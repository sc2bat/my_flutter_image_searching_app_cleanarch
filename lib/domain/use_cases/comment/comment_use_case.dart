import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/comment/comment_repository.dart';

class CommentUseCase {
  final CommentRepositoy _commentRepositoy;
  CommentUseCase({
    required CommentRepositoy commentRepositoy,
  }) : _commentRepositoy = commentRepositoy;

  Future<Result<void>> insert({
    required int userId,
    required int imageId,
    required String content,
  }) async {
    Map<String, dynamic> commentData = {
      'userId': userId,
      'imageId': imageId,
      'content': content,
    };
    final result = await _commentRepositoy.insertComment(commentData);

    return result.when(
      success: (_) {
        return Result.success(_);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<void>> edit({
    required int commentId,
    required String content,
  }) async {
    Map<String, dynamic> commentData = {
      'commentId': commentId,
      'content': content,
    };
    final result = await _commentRepositoy.editComment(commentData);

    return result.when(
      success: (_) {
        return Result.success(_);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  Future<Result<void>> delete({required int commentId}) async {
    Map<String, dynamic> commentData = {
      'commentId': commentId,
      'isDeleted': true,
    };
    final result = await _commentRepositoy.deleteComment(commentData);

    return result.when(
      success: (_) {
        return Result.success(_);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
