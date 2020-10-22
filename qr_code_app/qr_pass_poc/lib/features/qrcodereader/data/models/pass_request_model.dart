import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_request_entity.dart';

class PassRequestModel extends PassRequestEntity {
  PassModel pass;

  PassRequestModel({int storeId, this.pass}) : super(storeId, pass);

  static fromJson(Map<String, dynamic> jsonMap) {
    return PassRequestModel(
      storeId: jsonMap['storeId'],
      pass: PassModel.fromJson(jsonMap['pass'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "storeId": storeId,
      "pass": pass.toJson()
    };
  }


  // TODO GET SAVED STORE ID
  static PassRequestModel fromPassModel(PassModel model) {
    return PassRequestModel(
      storeId: 1,
      pass: model
    );
  }

}