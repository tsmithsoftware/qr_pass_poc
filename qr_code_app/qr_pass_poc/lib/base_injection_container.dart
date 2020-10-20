import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:qr_pass_poc/core/network/network_info.dart';
import 'package:qr_pass_poc/features/qrcodereader/injection_container.dart' as qr_code_reader;

final sl = GetIt.instance;

void init() {
  //! Features - qrcodereader
  qr_code_reader.init();
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}