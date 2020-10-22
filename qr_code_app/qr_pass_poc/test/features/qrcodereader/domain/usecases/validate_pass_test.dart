import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/pass_validation_repository.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/validate_pass.dart';

class MockPassValidationRepository extends Mock implements PassValidationRepository {}

void main() {
  ValidatePass usecase;
  MockPassValidationRepository mockPassValidationRepository;

  setUp(() {
    mockPassValidationRepository = MockPassValidationRepository();
    usecase = ValidatePass(mockPassValidationRepository);
  });

  final tResponse = PassValidationResponseModel(
    isPassValid: true
  );

  final params = Params();

  test('should get response for valid pass from repository',() async {
    when(mockPassValidationRepository.validatePass(any)).thenAnswer((_) async => Right(tResponse));
    final result = await usecase.call(params);
    expect(result, Right(tResponse));
    verify(mockPassValidationRepository.validatePass(params));
    verifyNoMoreInteractions(mockPassValidationRepository);
  });
}