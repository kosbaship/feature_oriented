import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feature_oriented/core/network/rest_client_service.dart';
import 'package:feature_oriented/core/utils/constants.dart';

class RestClientServiceImpl extends RestClientService {
  final Dio _dio = Dio();

  @override
  Future<Response> loginUser(String jsonBody) async {
    const url = LOGIN_USER;
    const headers = {'Content-type': 'application/json'};
    final body = jsonDecode(jsonBody);
    _dio.options.headers = headers;
    return await _dio.post(url, data: body);
  }
}
