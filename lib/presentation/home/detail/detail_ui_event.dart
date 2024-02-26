import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_ui_event.freezed.dart';

@freezed
abstract class DetailUiEvent<T> with _$DetailUiEvent<T> {
  const factory DetailUiEvent.showToast(String message) = ShowToast;
}
