import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/comment/user_comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/comment_repository.dart';

class UserCommentUseCase {
  final CommentRepositoy _commentRepositoy;
  UserCommentUseCase({
    required CommentRepositoy commentRepositoy,
  }) : _commentRepositoy = commentRepositoy;

  Future<Result<List<UserCommentModel>>> fetchAll(int userId) async {
    final result = await _commentRepositoy.getUserCommentList(userId);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }

  Future<Result<List<UserCommentModel>>> fetchPaginated(
      int userId, int offsetVal) async {
    final result =
        await _commentRepositoy.getPaginatedUserCommentList(userId, offsetVal);
    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
