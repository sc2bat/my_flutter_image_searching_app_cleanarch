import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ui_event.freezed.dart';

@freezed
abstract class SearchUiEvent<T> with _$SearchUiEvent<T> {
  const factory SearchUiEvent.showSnackBar(String message) = ShowSnackBar;
}
