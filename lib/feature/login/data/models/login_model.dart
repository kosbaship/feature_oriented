import 'package:feature_oriented/feature/login/domain/entities/login.dart';

class LoginModel   {
  int? status;
  String? message;
  Data? data;

  LoginModel({status, message, data}) ;

  LoginModel.fromJson(Map<String, dynamic> json)  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> toJsonData =  <String, dynamic>{};
    toJsonData['status'] = status;
    toJsonData['message'] = message;
    if (data != null) {
      toJsonData['data'] = data!.toJson();
    }
    return toJsonData;
  }
}

class Data {
  User? user;
  String? token;

  Data({user, token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;
  String? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {name,
        email,
        phone,
        role,
        updatedAt,
        createdAt,
        id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}