import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Response> fetchHttpData(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('response statusCode => ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch Data => $e');
  }
}
