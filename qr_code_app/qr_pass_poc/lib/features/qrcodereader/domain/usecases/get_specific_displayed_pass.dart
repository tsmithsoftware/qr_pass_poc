import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/displayed_pass_repository.dart';

class GetSpecificDisplayedPass extends UseCase<DisplayedPass, Params>{
  final DisplayedPassRepository repository;

  GetSpecificDisplayedPass(this.repository);

  @override
  Future<Either<Failure, DisplayedPass>> call(Params params) async {
    return await repository.getDisplayedPass(params.number);
  }
}