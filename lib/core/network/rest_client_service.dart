import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:feature_oriented/core/utils/constants.dart';

abstract class RestClientService {
  Future<Response> loginUser(String jsonBody);
}


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