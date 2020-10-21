import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';

abstract class PassValidationRepository {
  Future<Either<Failure, PassValidationResponseModel>> validatePass(Params params);
}