import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';

class DisplayedPassModel extends DisplayedPass {
  DisplayedPassModel({
    @required int passId,
    @required String visitorImageLink,
    @required String category,
    @required int passNumber,
    @required String visitorName
}): super (
    passId: passId,
    visitorImageLink: visitorImageLink,
    category: category,
    passNumber: passNumber,
    visitorName: visitorName
  );

  factory DisplayedPassModel.fromJson(Map<String, dynamic> jsonMap) {
    return DisplayedPassModel(
      passId: jsonMap['passId'],
      visitorImageLink: jsonMap['visitorImageLink'],
      passNumber: jsonMap['passNumber'],
      category: jsonMap['category'],
      visitorName: jsonMap['visitorName']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passId': passId,
      'visitorImageLink': visitorImageLink,
      'category': category,
      'passNumber': passNumber,
      'visitorName': visitorName
    };
  }
}