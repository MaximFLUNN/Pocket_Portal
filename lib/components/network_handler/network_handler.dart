import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:unn_mobile/components/network_handler/api_endpoints.dart';

class NetworkHandler {
  Future<http.Response> fetchData(String baseUrl, String path, Map<String, dynamic> queryParams, [Map<String, String>? headers]) async {
    final uri = Uri.https(baseUrl, path, queryParams);
    final response = await http.get(uri, headers: headers ?? {});
    return response;
  }

  Future<http.Response> fetchShedule(String start, String finish, String lng, [Map<String, String>? headers]) async {
    final queryParams = {
      'start': start,
      'finish': finish,
      'lng': lng
    };
    final response = await fetchData(ApiEndpoints.baseUrl, ApiEndpoints.schedulePathStaticGroup, queryParams, headers);
    return response;
  }
}
