import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

enum ImageSize {
  preview,
  webformat,
  large,
}

class DownloadBoxWidget extends StatefulWidget {
  final PhotoModel photoModel;
  const DownloadBoxWidget({
    super.key,
    required this.photoModel,
  });

  @override
  State<DownloadBoxWidget> createState() => _DownloadBoxWidgetState();
}

class _DownloadBoxWidgetState extends State<DownloadBoxWidget> {
  ImageSize? imageSize;

  @override
  void initState() {
    imageSize = ImageSize.webformat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.0,
      // constraints: BoxConstraints(
      //     minHeight: 200.0,
      //     maxHeight: MediaQuery.of(context).size.height * 0.6,
      // ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'preview ${widget.photoModel.previewWidth} x ${widget.photoModel.previewHeight}',
                  style: TextStyle(
                    color: weakBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    imageSize = ImageSize.preview;
                  });
                },
                leading: Radio<ImageSize>(
                  activeColor: baseColor,
                  value: ImageSize.preview,
                  groupValue: imageSize,
                  onChanged: (ImageSize? value) {
                    setState(() {
                      imageSize = value;
                    });
                  },
                ),
              ),
              const Divider(
                height: 16.0,
              ),
              ListTile(
                title: Text(
                  'webformat ${widget.photoModel.webformatWidth} x ${widget.photoModel.webformatHeight}',
                  style: TextStyle(
                    color: weakBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    imageSize = ImageSize.webformat;
                  });
                },
                leading: Radio<ImageSize>(
                  activeColor: baseColor,
                  value: ImageSize.webformat,
                  groupValue: imageSize,
                  onChanged: (ImageSize? value) {
                    setState(() {
                      imageSize = value;
                    });
                  },
                ),
              ),
              const Divider(
                height: 16.0,
              ),
              ListTile(
                title: Text(
                  'large ${widget.photoModel.imageWidth} x ${widget.photoModel.imageHeight}',
                  style: TextStyle(
                    color: weakBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  setState(() {
                    imageSize = ImageSize.large;
                  });
                },
                leading: Radio<ImageSize>(
                  activeColor: baseColor,
                  value: ImageSize.large,
                  groupValue: imageSize,
                  onChanged: (ImageSize? value) {
                    setState(() {
                      imageSize = value;
                    });
                  },
                ),
              ),
              const Divider(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  logger.info(imageSize);
                  switch (imageSize) {
                    case ImageSize.preview:
                      logger.info(widget.photoModel.previewUrl);
                      break;
                    case ImageSize.webformat:
                      logger.info(widget.photoModel.webformatUrl);
                      break;
                    case ImageSize.large:
                      logger.info(widget.photoModel.largeImageUrl);
                      break;
                    default:
                      break;
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'DOWNLOAD',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
