import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/network/network_info.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_local_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/pass_validation_repository.dart';

class PassValidationRepositoryImpl implements PassValidationRepository {
  final PassValidationRemoteDataSource remoteDataSource;
  final PassValidationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PassValidationRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PassValidationResponseModel>> validatePass(Params params) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.validatePass(params));
      } on ServerException {
        return await callLocalSource(params);
      }
    } else {
      return await callLocalSource(params);
    }
  }

  Future<Either<Failure, PassValidationResponseModel>> callLocalSource(Params params) async {
    try {
      return Right(await localDataSource.validatePass(params));
    } on CacheException {
      return Left(CacheFailure());
    }
  }

}