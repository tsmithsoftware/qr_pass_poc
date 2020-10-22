import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/validate_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';

class ValidateQrPassBloc extends Bloc<QrPassEvent, ValidateQrPassState> {
  final ValidatePassUseCase validateQrPass;

  ValidateQrPassBloc({
    @required ValidatePassUseCase concrete,
  })  : assert(concrete != null),
        validateQrPass = concrete, super(Empty());

  @override
  Stream<ValidateQrPassState> mapEventToState(
      QrPassEvent event,
      ) async* {
    if (event is ValidateQrPass) {
      yield Loading();
      final failureOrValidation = await validateQrPass(event.params);
      yield* _eitherLoadedOrErrorState(failureOrValidation);
    }
  }

  Stream<ValidateQrPassState> _eitherLoadedOrErrorState(Either<Failure, PassValidationResponseEntity> failureOrValidation) async* {
    yield failureOrValidation.fold(
            (failure) => Error(failure: failure),
            (validation) => Loaded(responseModel: validation)
    );
  }
}