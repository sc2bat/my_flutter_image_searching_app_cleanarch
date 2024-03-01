import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/like/like_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

void main() {
  test('list update test test001', () {
    List<LikeModel> likeList = List.generate(
        10,
        (index) => LikeModel(
            likeId: index,
            likeUserId: index,
            likeImageId: index,
            isLiked: index % 2 == 0 ? true : false,
            isDeleted: false));
    logger.info(likeList[3]);
    LikeModel item = LikeModel(
        likeId: 3,
        likeUserId: 3,
        likeImageId: 3,
        isLiked: true,
        isDeleted: false);

    for (var element in likeList) {
      if (element.likeId == item.likeId) {
        element.isLiked = item.isLiked;
      }
    }
    logger.info(likeList[3]);
  });
}
