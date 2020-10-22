import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';

abstract class PassValidationRepository {
  Future<Either<Failure, PassValidationResponseEntity>> validatePass(Params params);
}