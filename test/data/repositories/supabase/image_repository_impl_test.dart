import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('image info counting test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);

    int imageId = 5535486;

    final viewCount = await supabase
        .from(TB_VIEW_HISTORY)
        .select('view_image_id')
        .eq('view_image_id', imageId)
        .count();

    logger.info(viewCount);
    final downlaodCount = await supabase
        .from(TB_DOWNLOAD_HISTORY)
        .select('download_image_id')
        .eq('download_image_id', imageId)
        .count();

    logger.info(downlaodCount);
    final shareCount = await supabase
        .from(TB_SHARE_HISTORY)
        .select('share_image_id')
        .eq('share_image_id', imageId)
        .count();
    logger.info(shareCount);

    logger.info(
        'viewCount => $viewCount, downlaodCount=> $downlaodCount, shareCount => $shareCount');

    final Map<String, dynamic> data = {
      'view_count': viewCount.count,
      'download_count': downlaodCount.count,
      'share_count': shareCount.count,
    };

    logger.info(data);
  });

  test('getSinglePhotoFromSupabase fetch one test', () async {
    final supabase = SupabaseClient(Env.supabaseUrl, Env.supabaseApiKey);
    int imageId = 4670857;
    final data = await supabase
        .from(TB_IMAGE_INFO)
        .select()
        .eq('is_deleted', false)
        .eq('image_id', imageId)
        .single();

    PhotoModel photoModel = PhotoModel.fromJson(data);

    logger.info(photoModel);
    expect(photoModel.imageId, 4670857);
  });
}
