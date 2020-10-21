import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PassValidationLocalDataSource {
  Future<PassValidationResponseModel> validatePass(Params params);
}

class PassValidationLocalDataSourceImpl extends PassValidationLocalDataSource {
  final SharedPreferences sharedPreferences;

  PassValidationLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<PassValidationResponseModel> validatePass(Params params) {
    return null;
  }

}