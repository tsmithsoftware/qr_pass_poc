import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPassModel = PassModel(
    passNumber: 1442,
    passType: "PASS",
    visitorCompany: "BP",
    visitorName: "Bob",
    dateExpiry: "2021-10-21 23:00:00.000",
    dateValidFrom: "2020-10-20 12:00:00.000",
    passCategory: "A"
  );

  test(
    'should be a subclass of NumberTrivia entity',
        () async {
      // assert
      expect(tPassModel, isA<PassEntity>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('pass.json'));
        // act
        final result = PassModel.fromJson(jsonMap);
        // assert
        expect(result, tPassModel);
      },
    );
  });


  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tPassModel.toJson();
        // assert
        final expectedJsonMap = {
          "passNumber": 1442,
          "dateValidFrom": "2020-10-20 12:00:00.000",
          "dateExpiry": "2021-10-21 23:00:00.000",
          "passType": "PASS",
          "passCategory": "A",
          "visitorName": "Bob",
          "visitorCompany": "BP"
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}