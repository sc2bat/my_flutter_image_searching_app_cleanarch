import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int imageId;
  const DetailScreen({
    super.key,
    required this.imageId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController _commentTextEditingController;
  late PhotoModel photoModel;

  @override
  void initState() {
    Future.microtask(() {
      final detailViewModel = context.read<DetailViewModel>();
      detailViewModel.init(
        1, // userId
        widget.imageId,
      );
    });
    _commentTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<DetailViewModel>();
    final detailState = detailViewModel.detailState;

    if (detailState.photo != null) {
      photoModel = detailState.photo!;
    } else {
      photoModel = PhotoModel(imageId: 1);
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Image.network(
              photoModel.webformatUrl != null
                  ? photoModel.webformatUrl!
                  : noneImageUrl,
            ),
            Text(photoModel.tags != null ? photoModel.tags! : 'none'),
            detailState.isLiked != null
                ? Icon(detailState.isLiked!.isDeleted
                    ? Icons.favorite
                    : Icons.favorite_border)
                : Container(),
          ],
        ),
      ),
    );
  }
}
