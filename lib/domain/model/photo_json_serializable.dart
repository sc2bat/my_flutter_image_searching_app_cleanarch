// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_json_serializable.g.dart';

@JsonSerializable()
class PhotoJsonSerializable extends Equatable {
  final int id;
  final String tags;
  @JsonKey(name: 'previewURL')
  final String previewUrl;
  const PhotoJsonSerializable({
    required this.id,
    required this.tags,
    required this.previewUrl,
  });

  factory PhotoJsonSerializable.fromJson(Map<String, dynamic> json) =>
      _$PhotoJsonSerializableFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoJsonSerializableToJson(this);

  @override
  List<Object> get props => [id];
}
