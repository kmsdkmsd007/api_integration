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
import 'package:dummy/features/users/data/datasources/user_remote_data_source.dart';
import 'package:dummy/features/users/data/repositories/user_repository_impl.dart';
import 'package:dummy/features/users/domain/repositories/user_repository.dart';
import 'package:dummy/features/users/domain/usecases/fetch_usecas.dart';
import 'package:dummy/features/users/presentation/cubit/users_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final GetIt sl = GetIt.instance;
Future<void> init() async {
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUserCase: sl()));
  sl.registerFactory(() => SingupBloc(registerUsecas: sl()));
  sl.registerFactory(() => UsersCubit(sl, userRepository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<SignupRemoteDataSource>(
    () => SignupRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );

  // user case
  sl.registerLazySingleton(() => LoginUserCase(sl()));
  sl.registerLazySingleton(() => RegisterUsecas(sl()));
  sl.registerLazySingleton(() => FetchUsecas(sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
}
