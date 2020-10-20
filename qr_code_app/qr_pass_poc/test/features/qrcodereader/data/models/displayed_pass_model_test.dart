import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/displayed_pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tDisplayedPassModel = DisplayedPassModel(
    passId: 1,
    visitorImageLink: "https://www.thesoapopera.com/wp-content/uploads/2016/11/The-Soap-Opera-Giant-Rubber-Duck-Classic-1024x1024.jpg",
    category: "A",
    passNumber: 1442,
    visitorName: "Bob Shilstone"
  );

  test('should be a subclass of DisplayedPass entity', () async {
    expect(tDisplayedPassModel, isA<DisplayedPass>());
  });

  group('fromJson', (){
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('pass.json'));
      final result = DisplayedPassModel.fromJson(jsonMap);
      expect(result, tDisplayedPassModel);
    });
  });


  group('toJson', (){
    test('should return a JSON map containing the proper data', () async {
      final result = tDisplayedPassModel.toJson();
      final expectedJsonMap = {
        "passId": 1,
        "visitorImageLink": "https://www.thesoapopera.com/wp-content/uploads/2016/11/The-Soap-Opera-Giant-Rubber-Duck-Classic-1024x1024.jpg",
        "category": "A",
        "passNumber": 1442,
        "visitorName": "Bob Shilstone"
      };
      expect(result, expectedJsonMap);
    });
  });
}