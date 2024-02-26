import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_image_searching_app_cleanarch/utils/simple_logger.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('uuid test1', () {
    var uuid = const Uuid();
    String uuidString = uuid.toString();
    String uuidV1 = uuid.v1();

    logger.info('$uuid');
    logger.info('${uuid is String}');
    logger.info(uuidString);
    logger.info(uuidV1);
    logger.info('${uuidV1 is String}');
  });

  test('uuid test2 ', () {
    var uuid = const Uuid().v1();

    logger.info(uuid);
    logger.info('${uuid is String}');
  });
}
