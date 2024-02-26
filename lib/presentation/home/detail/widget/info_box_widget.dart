import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/widget/modal_title_widget.dart';

class InfoBoxWidget extends StatelessWidget {
  final PhotoModel photoModel;
  final int viewCount;
  final int downlaodCount;
  final int shareCount;
  const InfoBoxWidget({
    super.key,
    required this.photoModel,
    required this.viewCount,
    required this.downlaodCount,
    required this.shareCount,
  });

  String _calculateFileSize(int fileSize) {
    String calcFileSize = '';
    if (fileSize < 1024) {
      calcFileSize = '$fileSize B';
    } else if (fileSize < 1024 * 1024) {
      calcFileSize = '${(fileSize / 1024).toStringAsFixed(2)} KB';
    } else if (fileSize < 1024 * 1024 * 1024) {
      calcFileSize = '${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB';
    } else if (fileSize < 1024 * 1024 * 1024 * 1024) {
      calcFileSize = '${(fileSize / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
    } else {
      calcFileSize = 'ERROR';
    }
    return calcFileSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalTitleWidget(title: 'INFO'.toUpperCase()),
            const Divider(
              height: 8.0,
            ),
            Scrollbar(
              child: SingleChildScrollView(
                child: SizedBox(
                  // height: 280.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'views'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '$viewCount',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'downloads'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '$downlaodCount',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'shares'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '$shareCount',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'type'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '${photoModel.largeImageUrl?.split('.').last.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'size'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              _calculateFileSize(photoModel.imageSize != null
                                  ? photoModel.imageSize!.toInt()
                                  : 0),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'resolution'.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '${photoModel.imageWidth} x ${photoModel.imageHeight}',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
