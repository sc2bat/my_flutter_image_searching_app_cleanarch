// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/enums.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/widget/modal_title_widget.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class DownloadBoxWidget extends StatefulWidget {
  final PhotoModel photoModel;
  final Function(String imageSize, String downloadImageUrl) downloadFunction;
  const DownloadBoxWidget({
    Key? key,
    required this.photoModel,
    required this.downloadFunction,
  }) : super(key: key);

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
      height: 360.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ModalTitleWidget(title: 'resolution'.toUpperCase()),
              ListTile(
                title: Text(
                  '${widget.photoModel.previewWidth} x ${widget.photoModel.previewHeight}',
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
                  '${widget.photoModel.webformatWidth} x ${widget.photoModel.webformatHeight}',
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
                  '${widget.photoModel.imageWidth} x ${widget.photoModel.imageHeight}',
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
                  String size = '';
                  String downloadImageUrl = '';
                  switch (imageSize) {
                    case ImageSize.preview:
                      logger.info(widget.photoModel.previewUrl);
                      size =
                          '${widget.photoModel.previewWidth} x ${widget.photoModel.previewHeight}';
                      downloadImageUrl = widget.photoModel.previewUrl ?? '';
                      break;
                    case ImageSize.webformat:
                      logger.info(widget.photoModel.webformatUrl);
                      size =
                          '${widget.photoModel.webformatWidth} x ${widget.photoModel.webformatHeight}';
                      downloadImageUrl = widget.photoModel.webformatUrl ?? '';
                      break;
                    case ImageSize.large:
                      logger.info(widget.photoModel.largeImageUrl);
                      size =
                          '${widget.photoModel.imageWidth} x ${widget.photoModel.imageHeight}';
                      downloadImageUrl = widget.photoModel.largeImageUrl ?? '';
                      break;
                    default:
                      downloadImageUrl = '';
                      break;
                  }
                  if (downloadImageUrl != '') {
                    logger.info('download~');
                    Navigator.of(context).pop();
                  } else {
                    logger.info('IMAGE SIZE IN NULL');
                  }
                  widget.downloadFunction(size, downloadImageUrl);
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
