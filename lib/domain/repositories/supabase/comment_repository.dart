import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';

abstract interface class CommentRepository {
  Future<Result<List<CommentModel>>> getCommentList(int imageId);
  Future<Result<void>> insertComment(Map<String, dynamic> commentData);
  Future<Result<void>> editComment(Map<String, dynamic> commentData);
  Future<Result<void>> deleteComment(Map<String, dynamic> commentData);
  Future<Result<List<UserCommentModel>>> getUserCommentList(int userId);
  Future<Result<List<UserCommentModel>>> getPaginatedUserCommentList(
      int userId, int offsetVal);
}
