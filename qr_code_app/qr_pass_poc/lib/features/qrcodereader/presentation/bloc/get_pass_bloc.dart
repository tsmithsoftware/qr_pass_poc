import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/get_specific_displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class GetPassBloc extends Bloc<GetPassEvent, GetPassState> {
  final GetSpecificDisplayedPass getSpecificDisplayedPass;

  GetPassBloc({this.getSpecificDisplayedPass})
      :super(GetPassInitial());

  @override
  Stream<GetPassState> mapEventToState(
      GetPassEvent event,
      ) async* {
    if (event is GetConcretePass) {
      yield GetPassLoading();
       final failureOrPass = await getSpecificDisplayedPass(Params(number: event.passId));
       yield* _eitherLoadedOrErrorState(failureOrPass);
    }
  }

  Stream<GetPassState> _eitherLoadedOrErrorState(Either<Failure, DisplayedPass> failureOrPass) async* {
    yield failureOrPass.fold(
        (failure) => GetPassError(ServerFailure()),
        (pass) => GetPassLoaded(pass: pass)
    );
  }
}