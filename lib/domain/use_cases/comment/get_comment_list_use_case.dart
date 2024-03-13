import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/comment/comment_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/comment_repository.dart';

class GetCommentListUseCase {
  final CommentRepository _commentRepositoy;
  GetCommentListUseCase({
    required CommentRepository commentRepositoy,
  }) : _commentRepositoy = commentRepositoy;

  Future<Result<List<CommentModel>>> fetch(int imageId) async {
    final result = await _commentRepositoy.getCommentList(imageId);
    return result.when(
      success: (data) => Result.success(data),
      error: (error) => Result.error(error),
    );
  }
}
