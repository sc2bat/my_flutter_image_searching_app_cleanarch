import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/widget/modal_title_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareBoxWidget extends StatelessWidget {
  const ShareBoxWidget({
    super.key,
    required this.pageUrl,
    required this.shareFunction,
  });

  final String pageUrl;
  final Function(String message) shareFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ModalTitleWidget(title: 'SHARE'.toUpperCase()),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4.0,
                    color: weakBlack,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: QrImageView(
                    data: pageUrl,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(text: pageUrl),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: pageUrl)).then((_) {
                        const message = 'Image url copied successfully!';
                        shareFunction(message);
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: baseColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
