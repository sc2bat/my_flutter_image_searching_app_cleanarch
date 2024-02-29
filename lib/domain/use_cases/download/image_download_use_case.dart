import 'dart:io';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/repositories/photo/photo_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageDownloadUseCase {
  final PhotoRepository _photoRepository;
  ImageDownloadUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  Future<Result<String>> saveImage(downloadImageUrl) async {
    final result = await _photoRepository.getImageBytes(downloadImageUrl);

    return result.when(success: (response) async {
      try {
        final dir = await getTemporaryDirectory();

        String uuidV1 = const Uuid().v1();

        String fileName =
            '${dir.path}/image_craft_$uuidV1.${downloadImageUrl.split('.').last}';

        final file = File(fileName);

        await file.writeAsBytes(response.bodyBytes);

        final params = SaveFileDialogParams(sourceFilePath: file.path);
        final finalPath = await FlutterFileDialog.saveFile(params: params);

        if (finalPath != null) {
          return Result.success(fileName);
        } else {
          return const Result.error('saveImage finalPath null error');
        }
      } catch (e) {
        return Result.error('$e');
      }
    }, error: (error) {
      return const Result.error('saveImage error');
    });
  }
}
