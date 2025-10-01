import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/repositories/auth_repository_impl.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:dummy/features/singup/data/datasources/signup_remote_data_source.dart';
import 'package:dummy/features/singup/data/repositories/sign_up_repository_impl.dart';
import 'package:dummy/features/singup/domain/repositories/sign_up_repository.dart';
import 'package:dummy/features/singup/domain/usecases/register_usecas.dart';
import 'package:dummy/features/singup/presentation/bloc/singup_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;
Future<void> init() async {
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUserCase: sl()));
  sl.registerFactory(() => SingupBloc(registerUsecas: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(client: sl()),
  );

  // user case
  sl.registerLazySingleton(() => LoginUserCase(sl()));
  sl.registerLazySingleton(() => RegisterUsecas(sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
}
