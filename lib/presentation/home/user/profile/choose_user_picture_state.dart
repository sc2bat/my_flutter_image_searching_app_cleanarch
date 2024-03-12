import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';

part 'choose_user_picture_state.freezed.dart';

@freezed
class ChooseUserPictureState with _$ChooseUserPictureState {
  const factory ChooseUserPictureState({
    @Default(false) bool isLoading,
    @Default('') String userUuid,
    @Default('') String selectedUserPicture,
    @Default([]) List<PhotoModel> photoList,
  }) = _ChooseUserPictureState;
}
