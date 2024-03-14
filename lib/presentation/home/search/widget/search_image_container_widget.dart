import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/presentation/common/theme.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

class SearchImageContainerWidget extends StatelessWidget {
  final PhotoModel photo;
  final LikeModel? likeModel;
  final Function(LikeModel likeModel) updateLikeStateFunction;
  final Function(LikeModel likeModel) updateLikeFunction;

  const SearchImageContainerWidget({
    super.key,
    required this.photo,
    this.likeModel,
    required this.updateLikeStateFunction,
    required this.updateLikeFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await context.push(
          '/detail',
          extra: {
            'imageId': photo.imageId,
          },
        );

        if (result is LikeModel) {
          await updateLikeStateFunction(result);
        }
      },
      onDoubleTap: () {
        if (likeModel != null) {
          logger.info('double tap');
          updateLikeFunction(likeModel!);
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: DecorationImage(
                image: NetworkImage(photo.previewUrl ?? ''),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 4.0,
                  offset: const Offset(2, 2),
                  color: Colors.grey.withOpacity(0.6),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: likeModel != null && likeModel!.isLiked
                ? const Icon(
                    Icons.favorite,
                    color: baseColor,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
