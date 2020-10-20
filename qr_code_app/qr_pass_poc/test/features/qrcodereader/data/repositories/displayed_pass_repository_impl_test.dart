import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/network/network_info.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/displayed_pass_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/displayed_pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/repositories/displayed_pass_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements DisplayedPassRemoteDataSource {}

class MockNetworkInfo extends Mock
    implements NetworkInfo {}

void main() {
  DisplayedPassRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  DisplayedPassModel tPassModel;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DisplayedPassRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
    tPassModel = DisplayedPassModel(
      passId: 1,
      passNumber: 2,
      visitorImageLink: "http://link",
      category: "A"
    );
  });

  group('getDisplayedPass', () {
    final tNumber = 1;
    test('should check if the device is online', () {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getDisplayedPass(tNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      // This setUp applies only to the 'device is online' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDisplayedPass(tNumber))
              .thenAnswer((_) async => tPassModel);
          // act
          final result = await repository.getDisplayedPass(tNumber);
          // assert
          verify(mockRemoteDataSource.getDisplayedPass(tNumber));
          expect(result, equals(Right(tPassModel)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getDisplayedPass(tNumber))
              .thenThrow(ServerException());
          // act
          final result = await repository.getDisplayedPass(tNumber);
          // assert
          verify(mockRemoteDataSource.getDisplayedPass(tNumber));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', (){
      // This setUp applies only to the 'device is offline' group
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return connection failure when device not connected', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repository.getDisplayedPass(tNumber);
        // assert
        verify(mockNetworkInfo.isConnected);
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });

}