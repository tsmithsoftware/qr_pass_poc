import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';

abstract class PassValidationRemoteDataSource {
  Future<PassValidationResponseModel> validatePass(Params params);
}