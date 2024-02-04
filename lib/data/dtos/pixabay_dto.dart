import 'package:my_flutter_image_searching_app_cleanarch/data/dtos/hit_dto.dart';

class PixabayDTO {
  final int total;
  final int totalHits;
  final List<HitDTO> hits;

  PixabayDTO({
    required this.total,
    required this.totalHits,
    required this.hits,
  });

  factory PixabayDTO.fromJson(Map<String, dynamic> json) {
    return PixabayDTO(
      total: json['total'] ?? 0,
      totalHits: json['totalHits'] ?? 0,
      hits: (json['hits'] as List<dynamic>?)
              ?.map(
                  (hitJson) => HitDTO.fromJson(hitJson as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
