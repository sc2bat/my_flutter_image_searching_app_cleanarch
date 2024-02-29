import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('like count test', () async {
    int imageId = 5535486;
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    try {
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .select('like_id')
          .eq('like_image_id', imageId)
          .count();
      logger.info(result);
      logger.info(result.count);
    } catch (e) {
      logger.info(e);
    }
  });

  test('like only handler data test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    Map<String, dynamic> jsonData = {
      'like_id': 16,
      'like_user_id': 1,
      'like_image_id': 5535486,
      'is_liked': false,
      'is_deleted': false,
    };

    logger.info('LikeRepositoryImpl handleLike');
    logger.info(jsonData);
    bool isLiked = !jsonData['is_liked'];
    try {
      logger.info('LikeRepositoryImpl handleLike');
      logger.info('jsonData is_liked ${jsonData['is_liked']}');
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .update({
            'is_liked': isLiked,
          })
          .eq('like_user_id', jsonData['like_user_id'])
          .eq('like_image_id', jsonData['like_image_id'])
          .eq('like_id', jsonData['like_id'])
          .select()
          .single();
      logger.info(result);
    } catch (e) {
      logger.info(e);
    }
  });

  test('like handler data test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    int userId = 1;
    int imageId = 5535486;
    Map<String, dynamic> data = {};

    final countData = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .count();
    int count = countData.count;

    logger.info(count);

    if (count == 0) {
      await supabase
          .from(TB_LIKE_HISTORY)
          .insert({'like_user_id': userId, 'like_image_id': imageId});
    }
    data = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .single();

    logger.info(data);

    logger.info(data['is_liked']);

    /**
     * 
    final inputData = LikeModel(
      likeId: data['like_id'],
      likeUserId: userId,
      likeImageId: imageId,
      isLiked: !data['isLiked'],
      isDeleted: false,
    );

    final jsonData = jsonEncode(inputData);
    logger.info(jsonData);
     */

    try {
      final result = await supabase
          .from(TB_LIKE_HISTORY)
          .update({
            'is_liked': !data['is_liked'],
          })
          .eq('like_user_id', userId)
          .eq('like_image_id', imageId)
          .eq('like_id', data['like_id'])
          .select()
          .single();
      logger.info(result);
    } catch (e) {
      logger.info(e);
    }
  });

  test('_likeRepositoryImpl getLikeData', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    int userId = 1;
    int imageId = 5535486;
    Map<String, dynamic> data = {};

    final countData = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .count();
    int count = countData.count;

    logger.info(count);

    if (count == 0) {
      await supabase
          .from(TB_LIKE_HISTORY)
          .insert({'like_user_id': userId, 'like_image_id': imageId});
    }
    data = await supabase
        .from(TB_LIKE_HISTORY)
        .select()
        .eq('like_user_id', userId)
        .eq('like_image_id', imageId)
        .single();

    logger.info(data);
  });
}
