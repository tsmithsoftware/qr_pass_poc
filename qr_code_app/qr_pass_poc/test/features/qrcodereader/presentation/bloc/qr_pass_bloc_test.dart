import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/validate_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';

class MockUseCase extends Mock implements ValidatePassUseCase {}

void main() {
  ValidateQrPassBloc bloc;
  MockUseCase validatePassUseCase;
  PassValidationResponseEntity tResponseEntity =
      PassValidationResponseEntity(isPassValid: true);
  Params params = Params();

  setUp(() {
    validatePassUseCase = MockUseCase();
    bloc = ValidateQrPassBloc(concrete: validatePassUseCase);
  });

  test(
    'should get data from the concrete use case',
    () async {
      // arrange
      when(validatePassUseCase(any))
          .thenAnswer((_) async => Right(tResponseEntity));
      // act
      bloc.add(ValidateQrPass(params));
      await untilCalled(validatePassUseCase(any)).timeout(Duration(seconds: 5));
      // assert
      verify(validatePassUseCase(params));
    },
  );

  test('initial state is Empty', (){
    assert(bloc.state == Empty());
  });

  test(
    'should emit [Loading, Loaded] when data is obtained successfully',
    () async {
      // arrange
      when(validatePassUseCase(any))
          .thenAnswer((_) async => Right(tResponseEntity));
      // assert later
      final expected = [
        Loading(),
        Loaded(responseModel: tResponseEntity),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(ValidateQrPass(params));
    },
  );

  test(
    'should emit [Loading, Error] when getting data fails',
        () async {
          // arrange
          when(validatePassUseCase(any))
              .thenAnswer((_) async => Left(ServerFailure()));
          // assert later
          final expected = [
            Loading(),
            Error(failure: ServerFailure()),
          ];
          expectLater(bloc, emitsInOrder(expected));
          // act
          bloc.add(ValidateQrPass(params));
    },
  );
}
