import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/const_urls.dart';
import 'package:my_flutter_image_searching_app_cleanarch/env/env.dart';
import 'package:my_flutter_image_searching_app_cleanarch/logger/simple_logger.dart';

void main() {
  test('API KEY generator Test', () {
    logger.info(Env.pixabayApiKey);
  });

  test('API URL generator Test', () {
    logger.info(pixabayApiUrl);
  });
}
