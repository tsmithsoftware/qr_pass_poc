import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/network/network_info.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_local_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/repositories/pass_validation_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements PassValidationRemoteDataSource {}

class MockLocalDataSource extends Mock implements PassValidationLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PassValidationRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  PassRequestModel pass;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PassValidationRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('ValidatePass', () {
    final tPassValidationResponseModel = PassValidationResponseModel(
      isPassValid: true
    );

    Params params = Params(pass: pass);
    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.validatePass(params);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.validatePass(params))
              .thenAnswer((_) async => tPassValidationResponseModel);
          // act
          final result = await repository.validatePass(params);
          // assert
          verify(mockRemoteDataSource.validatePass(params));
          expect(result, equals(Right(tPassValidationResponseModel)));
        },
      );

      test(
        'should return data from cache when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.validatePass(params))
              .thenThrow(ServerException(500, "error"));
          when(mockLocalDataSource.validatePass(params))
              .thenAnswer((_) async => tPassValidationResponseModel);
          // act
          final result = await repository.validatePass(params);
          // assert
          verify(mockRemoteDataSource.validatePass(params));
          verify(mockLocalDataSource.validatePass(params));
          expect(result, equals(Right(tPassValidationResponseModel)));
        },
      );

    });

    group('device is offline', (){

      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should validate the data locally when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.validatePass(params))
              .thenAnswer((_) async => tPassValidationResponseModel);
          // act
          await repository.validatePass(params);
          // assert
          verify(mockLocalDataSource.validatePass(params));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
            () async {
          // arrange
          when(mockLocalDataSource.validatePass(params))
              .thenThrow(CacheException("error"));
          // act
          final result = await repository.validatePass(params);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.validatePass(params));
          expect(result, equals(Left(CacheFailure())));
        },
      );

    });
  });
}