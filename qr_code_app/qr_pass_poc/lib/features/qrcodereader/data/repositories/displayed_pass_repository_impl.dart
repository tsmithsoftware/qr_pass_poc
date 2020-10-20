import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/network/network_info.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/displayed_pass_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/displayed_pass_repository.dart';

class DisplayedPassRepositoryImpl implements DisplayedPassRepository {
  final DisplayedPassRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DisplayedPassRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo
  });

  @override
  Future<Either<Failure, DisplayedPass>> getDisplayedPass(int passId) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getDisplayedPass(passId));
      }
      on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}