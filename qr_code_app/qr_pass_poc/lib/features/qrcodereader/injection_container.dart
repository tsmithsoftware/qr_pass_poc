import 'package:get_it/get_it.dart';
import 'package:qr_pass_poc/data/moor_database.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_local_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/repositories/pass_validation_repository_impl.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/pass_validation_repository.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/validate_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => ValidateQrPassBloc(concrete: sl()));
  // Use Cases
  sl.registerLazySingleton(() => ValidatePassUseCase(sl()));
  // Repositories
  sl.registerLazySingleton<PassValidationRepository>(() => PassValidationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
  // Data Sources
  sl.registerLazySingleton<PassValidationRemoteDataSource>(() => PassValidationRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PassValidationLocalDataSource>(() => PassValidationLocalDataSourceImpl(passDatabase: sl()));
  sl.registerLazySingleton<PassDatabase>(() => PassDatabase());
}