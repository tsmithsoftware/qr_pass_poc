import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/data/moor_database.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';

abstract class PassValidationLocalDataSource {
  Future<PassValidationResponseModel> validatePass(Params params);
}

class PassValidationLocalDataSourceImpl extends PassValidationLocalDataSource {
  final PassDatabase passDatabase;

  PassValidationLocalDataSourceImpl({@required this.passDatabase});

  @override
  Future<PassValidationResponseModel> validatePass(Params params) async {
    List<PassRecord> result = await passDatabase.getAllRecords();
    Iterable<PassRecord> results = result.where((element) => elementMatchesParams(element, params));
    PassValidationResponseModel model = PassValidationResponseModel(isPassValid: false);
    if(results != null) {
      if (results.isNotEmpty) {
        model = PassValidationResponseModel(isPassValid: true);
      }
    }
    return Future.value(model);
  }

  bool elementMatchesParams(PassRecord element, Params params) {
    if (params.pass != null) {
      PassRequestModel pass = params.pass;
      if (pass.storeId != null) {
        if(pass.pass != null) {
          PassModel passModel = pass.pass;
          return (
              (element.storeId == pass.storeId) &&
                  (element.passCategory == passModel.passCategory) &&
                  (element.dateExpiry == passModel.dateExpiry) &&
                  (element.passNumber == passModel.passNumber) &&
                  (element.passType == passModel.passType) &&
                  (element.visitorName == passModel.visitorName) &&
                  (element.visitorCompany == passModel.visitorCompany)
          );
        }
        else return (element.storeId == pass.storeId);
      }
    }
    return false;
  }

}