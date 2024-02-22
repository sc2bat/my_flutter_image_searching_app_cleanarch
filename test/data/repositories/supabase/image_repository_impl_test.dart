import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/domain/model/photo_model.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
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
