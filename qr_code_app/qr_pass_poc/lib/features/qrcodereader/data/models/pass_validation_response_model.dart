import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';

class PassValidationResponseModel extends PassValidationResponseEntity {
  final bool isPassValid;
  final PassModel pass;

  PassValidationResponseModel({this.isPassValid, this.pass});

  static fromJson(Map<String, dynamic> jsonMap) {
    dynamic passJson = jsonMap['pass']['pass'];
    dynamic isPassValid = jsonMap['isPassValid'];
    return PassValidationResponseModel(
        isPassValid:isPassValid, pass: PassModel.fromJson(passJson));
  }

  Map<String, dynamic> toJson() {
    return {"isPassValid": isPassValid, "pass": pass.toJson()};
  }
}
