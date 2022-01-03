import 'package:feature_oriented/feature/login/domain/entities/login.dart';

class LoginModel extends Login {
  LoginModel({status, message, data}) : super(data: data);

  LoginModel.fromJson(Map<String, dynamic> json) : super(data: json);
}

