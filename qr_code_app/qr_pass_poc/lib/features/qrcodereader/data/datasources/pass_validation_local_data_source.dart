import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/data/moor_database.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PassValidationLocalDataSource {
  Future<PassValidationResponseModel> validatePass(Params params);
}

class PassValidationLocalDataSourceImpl extends PassValidationLocalDataSource {
  final PassDatabase passDatabase;

  PassValidationLocalDataSourceImpl({@required this.passDatabase});

  @override
  Future<PassValidationResponseModel> validatePass(Params params) async {
    List<PassRecord> result = await passDatabase.getAllRecords();

  }

}