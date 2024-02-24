import 'package:flutter/material.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/main.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/home/detail/detail_view_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/widget/common/sign_elevated_button_widget.dart';
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

  final session = supabase.auth.currentSession;

  @override
  void initState() {
    Future.microtask(() {
      // int userId = 0;
      // if (session != null) {
      //   userId = int.parse(session!.user.id);
      //   logger.info(userId);
      // }
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ImageCraft',
          style: TextStyle(
            color: baseColor,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: const Offset(2.0, 2.0),
                blurRadius: 4.0,
                color: Colors.grey.withOpacity(0.5),
              ),
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: SignElevatedButtonWidget(),
          ),
        ],
        backgroundColor: Colors.white,
      ),
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
