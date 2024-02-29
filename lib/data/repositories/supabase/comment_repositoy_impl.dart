import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/comment_repository.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';

class CommentRepositoyImpl implements CommentRepositoy {
  @override
  Future<Result<List<CommentModel>>> getCommentList(int imageId) async {
    try {
      final List<Map<String, dynamic>> data = await supabase.rpc(
        FUNC_GET_IMAGE_COMMENT,
        params: {
          'image_id_param': imageId,
        },
      );

      return Result.success(data.map((e) => CommentModel.fromJson(e)).toList());
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> insertComment(Map<String, dynamic> commentData) async {
    try {
      await supabase.from(TB_USER_COMMENT).insert({
        'comment_user_id': commentData['userId'],
        'comment_image_id': commentData['imageId'],
        'comment_content': commentData['content'],
      });

      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> editComment(Map<String, dynamic> commentData) async {
    try {
      await supabase.from(TB_USER_COMMENT).update({
        'comment_content': commentData['content'],
      }).eq('comment_id', commentData['commentId']);
      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<void>> deleteComment(Map<String, dynamic> commentData) async {
    try {
      await supabase.from(TB_USER_COMMENT).update({
        'comment_is_deleted': commentData['isDeleted'],
      }).eq('comment_id', commentData['commentId']);

      return const Result.success(null);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
