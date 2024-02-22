import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Map<String, dynamic>> topTags,
    @Default([]) List<Map<String, dynamic>> populars,
  }) = _HomeState;
}
