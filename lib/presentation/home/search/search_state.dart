import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/user_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String searchKeyword,
    @Default([]) List<String> searchHistories,
    @Default(false) bool isLoading,
    @Default([]) List<PhotoModel> photos,
    @Default([]) List<LikeModel> likeList,
    UserModel? userModel,
  }) = _SearchState;
}
