import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/supabase/like_repository.dart';

class SearchLikeUseCase {
  final LikeRepository _likeRepository;
  SearchLikeUseCase({
    required LikeRepository likeRepository,
  }) : _likeRepository = likeRepository;

  Future<Result<List<LikeModel>>> fetch(
      int userId, List<PhotoModel> photoList) async {
    List<LikeModel> likeList = [];

    try {
      for (int i = 0; i < photoList.length; i++) {
        final result =
            await _likeRepository.getLikeData(userId, photoList[i].imageId);
        result.when(
          success: (data) => likeList.add(data),
          error: (message) => Result.error(message),
        );
      }
      return Result.success(likeList);
    } catch (e) {
      return Result.error('SearchLikeUseCase fetch $e');
    }
  }

  Future<Result<LikeModel>> updateLike(LikeModel likeModel) async {
    final jsonData = likeModel.toJson();

    final result = await _likeRepository.handleLike(jsonData);

    return result.when(
      success: (data) => Result.success(LikeModel.fromJson(data)),
      error: (message) => Result.error(message),
    );
  }
}
