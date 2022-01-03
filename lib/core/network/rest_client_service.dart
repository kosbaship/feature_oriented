import 'package:dio/dio.dart';

abstract class RestClientService {
  Future<Response> loginUser(String jsonBody);
}
