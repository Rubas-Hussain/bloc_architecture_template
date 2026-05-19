import '../features/home/data/data_source/home_remote_data_source.dart';
import '../features/home/data/repository/home_repository_impl.dart';
import '../features/home/domain/repository/home_repository.dart';
import '../features/home/domain/use_case/home_use_case.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../main.dart';
import '../services/auth_service.dart';

class DependencyInjection {

  static void setupDI(){
    // getIt.registerLazySingleton<AuthService>(() => AuthService());
    // Data Source
    getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource(),);

    // Repository
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()),);

    // UseCase
    getIt.registerLazySingleton(() => HomeUseCase(getIt()),);

    // Bloc
    getIt.registerFactory(() => HomeBloc(getIt()),);
  }
}