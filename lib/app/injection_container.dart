import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:feature_oriented/core/network/network_info.dart';
import 'package:feature_oriented/core/network/rest_client_service.dart';
import 'package:feature_oriented/core/network/rest_clint_servce_dio.dart';
import 'package:feature_oriented/feature/login/data/datasources/login_remote_datasource.dart';
import 'package:feature_oriented/feature/login/data/repositories/login_repository_impl.dart';
import 'package:feature_oriented/feature/login/domain/repositories/login_repository.dart';
import 'package:feature_oriented/feature/login/domain/usecases/login_user.dart';
import 'package:feature_oriented/feature/login/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> init() async {
  //Blocs
  sl.registerFactory(
        () => LoginCubit(
      loginUser: sl(),
    ) ,
  );

  //Use cases
  sl.registerLazySingleton(() => LoginUser(repository: sl()));

  //Repositories
  sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );


  //Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImpl(
      restClientService: sl(),
    ),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(dataConnectionChecker: sl()),
  );

  //External
  sl.registerLazySingleton(() => Connectivity().checkConnectivity());

  sl.registerLazySingleton(() => RestClientServiceImpl());
}