
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tPassValidationModel = PassValidationModel(
    passId: 1442
  );

  test('should be a subclass of PassValidation entity', () async {
    expect(tPassValidationModel, isA<PassValidation>());
  });


  group('fromJson', (){
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('validation.json'));
      final result = PassValidationModel.fromJson(jsonMap);
      expect(result, tPassValidationModel);
    });
  });

  group('toJson', (){
    test('should return a JSON map containing the proper data', () async {
      final result = tPassValidationModel.toJson();
      final expectedJsonMap = {
        "passId": 1442,
      };
      expect(result, expectedJsonMap);
    });
  });

}