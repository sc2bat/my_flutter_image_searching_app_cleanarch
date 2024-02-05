import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(false) bool isLoading,
    @Default([]) List<PhotoModel> photos,
  }) = _SearchState;
}
