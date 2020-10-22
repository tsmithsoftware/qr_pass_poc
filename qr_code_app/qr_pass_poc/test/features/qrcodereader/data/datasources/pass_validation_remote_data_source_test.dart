import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:qr_pass_poc/core/error/exception.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_remote_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  PassValidationRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;
  Params storeIdParams = Params(pass: PassRequestModel(storeId: 1));
  Params allParams = Params(
      pass: PassRequestModel(
          storeId: 1,
          pass: PassModel(
            passType: "LOA",
            visitorCompany: "BP",
            visitorName: "Bob",
            dateExpiry: "2020-10-20 12:00:00.000",
            passCategory: "A",
            passNumber: 1,
            dateValidFrom: "2020-10-20 12:00:00.000",
          )));
  final tPassValidationResponse = PassValidationResponseModel(
    isPassValid: true
  );

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = PassValidationRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('validate pass', () {
    final tNumber = 1;

    test(
      'should perform a POST request on a URL with application/json header',
      () {
        //arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async =>
              http.Response(fixture('pass_validation_response_true.json'), 200),
        );
        // act
        dataSource.validatePass(allParams);
        // assert
        verify(mockHttpClient.post(
          'http://localhost:8080/validate',
          body: anyNamed('body'),
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.toString()
          },
        ));
      },
    );

    test(
      'should return PassValidationResponseModel when the response code is 200 (success)',
          () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(fixture('pass_validation_response_true.json'), 200),
        );
        // act
        final result = await dataSource.validatePass(allParams);
        // assert
        expect(result, equals(tPassValidationResponse));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.post(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response('Something went wrong', 404),
        );
        // act
        final call = dataSource.validatePass;
        // assert
        expect(() => call(allParams), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
