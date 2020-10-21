import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';

class PassValidationResponseModel extends PassValidationResponseEntity {
  final bool isPassValid;

  PassValidationResponseModel({this.isPassValid});

  static fromJson(Map<String, dynamic> jsonMap) {
    return PassValidationResponseModel(
        isPassValid: jsonMap['isPassValid']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isPassValid": isPassValid
    };
  }
}