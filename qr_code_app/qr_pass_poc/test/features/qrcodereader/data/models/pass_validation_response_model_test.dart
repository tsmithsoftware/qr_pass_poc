import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final tPassValidationresponseModel = PassValidationResponseModel(
    isPassValid: true,
    pass: PassModel(
      passNumber: 1442,
      dateValidFrom: "2020-10-20 12:00:00.000",
      dateExpiry: "2021-10-21 23:00:00.000",
      passType: "PASS",
      passCategory: "A",
      visitorName: "Bob",
      visitorCompany: "BP"
    )
  );

  test('should be a subclass of the PassValidationResponseEntity', (){
    expect(tPassValidationresponseModel, isA<PassValidationResponseEntity>());
  });

  group('fromJSON', (){
    test(
        'should return a valid model',
            () async {
              // arrange
              final Map<String, dynamic> jsonMap =
              json.decode(fixture('pass_validation_response_true.json'));
              // act
              final result = PassValidationResponseModel.fromJson(jsonMap);
              // assert
              expect(result, tPassValidationresponseModel);
    });
  });

  group('toJSON', (){
    test(
        'should return a JSON map containing the proper data',
            () async {
              final result = tPassValidationresponseModel.toJson();
              // assert
              final expectedJsonMap = {
                "isPassValid": true,
                "pass": {
                  "passNumber": 1442,
                  "dateValidFrom": "2020-10-20 12:00:00.000",
                  "dateExpiry": "2021-10-21 23:00:00.000",
                  "passType": "PASS",
                  "passCategory": "A",
                  "visitorName": "Bob",
                  "visitorCompany": "BP"
                }
              };
              expect(result, expectedJsonMap);
    });
  });
}