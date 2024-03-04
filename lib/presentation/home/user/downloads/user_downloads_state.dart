import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/user/download/user_download_model.dart';

part 'user_downloads_state.freezed.dart';

@freezed
class UserDownloadsState with _$UserDownloadsState {
  const factory UserDownloadsState({
    @Default(false) bool isLoading,
    @Default(false) bool additionalLoading,
    @Default(0) int userId,
    @Default(0) int currentItemCount,
    @Default([]) List<UserDownloadModel> downloadList,
  }) = _UserDownloadsState;
}
