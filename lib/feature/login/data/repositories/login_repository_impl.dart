import 'package:dartz/dartz.dart';
import 'package:feature_oriented/core/error/exceptions.dart';
import 'package:feature_oriented/core/error/failures.dart';
import 'package:feature_oriented/core/network/network_info.dart';
import 'package:feature_oriented/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:feature_oriented/feature/login/domain/entities/login.dart';
import 'package:feature_oriented/feature/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Login>> loginUser(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.loginUser(email, password);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
