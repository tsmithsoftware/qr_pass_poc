import 'package:get_it/get_it.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/displayed_pass_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/repositories/displayed_pass_repository_impl.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/displayed_pass_repository.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/get_specific_displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => GetPassBloc(
    getSpecificDisplayedPass: sl()
  ));
  // Use cases
  sl.registerLazySingleton(() => GetSpecificDisplayedPass(sl()));
  // Data Sources
  sl.registerLazySingleton<DisplayedPassRemoteDataSource>(() => DisplayedPassRemoteDataSourceImpl(client: sl()));
  // Repository
  sl.registerLazySingleton<DisplayedPassRepository>(() => DisplayedPassRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
}