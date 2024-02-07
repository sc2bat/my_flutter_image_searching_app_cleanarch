import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/constants.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';

void main() {
  test('API KEY generator Test', () {
    logger.info(Env.pixabayApiKey);
    logger.info(pixabayApiUrl);
    logger.info(Env.supabaseApiKey);
    logger.info(Env.supabaseUrl);
    logger.info(supabaseLoginCallback);

    expect(supabaseLoginCallback,
        'io.supabase.flutterquickstart://login-callback/');
  });
}
