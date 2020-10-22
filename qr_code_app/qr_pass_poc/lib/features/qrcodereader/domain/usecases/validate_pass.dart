import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/pass_validation_repository.dart';

class ValidatePassUseCase extends UseCase<PassValidationResponseEntity, Params>{
  final PassValidationRepository repository;

  ValidatePassUseCase(this.repository);

  @override
  Future<Either<Failure, PassValidationResponseEntity>> call(Params params) async {
      return await repository.validatePass(params);
    }
}