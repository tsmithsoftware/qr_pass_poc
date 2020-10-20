import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation.dart';

class PassValidationModel extends PassValidation{
  PassValidationModel({@required int passId}): super (passId: passId);

  factory PassValidationModel.fromJson(Map<String, dynamic> jsonMap) {
    return PassValidationModel(
        passId: jsonMap['passId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passId': passId
    };
  }
}