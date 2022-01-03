import 'package:dartz/dartz.dart';
import 'package:feature_oriented/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
