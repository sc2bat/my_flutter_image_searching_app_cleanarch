import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_flutter_image_searching_app_cleanarch/data/data_sources/result.dart';

Future<Result<Response>> fetchHttpData(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Result.success(response);
    } else {
      return Result.error('response statusCode => ${response.statusCode}');
    }
  } catch (e) {
    return Result.error('response statusCode => $e');
  }
}
