import 'package:dartz/dartz.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/feature/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> loginUser(String email, String password);
}
