import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/repositories/displayed_pass_repository.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/get_specific_displayed_pass.dart';

class MockPassRepository extends Mock implements DisplayedPassRepository {}

void main() {
  GetSpecificDisplayedPass usecase;
  MockPassRepository mockPassRepository;

  setUp((){
    mockPassRepository = MockPassRepository();
    usecase = GetSpecificDisplayedPass(mockPassRepository);
  });

  final tNumber = 1;
  final tPass = DisplayedPass(
      passId: 1,
      category: "A",
      passNumber: 12,
      visitorImageLink: "https://www.thesoapopera.com/wp-content/uploads/2016/11/The-Soap-Opera-Giant-Rubber-Duck-Classic-1024x1024.jpg"
  );

  test('should get pass for number from repo', () async {
    when (mockPassRepository.getDisplayedPass(any)).thenAnswer((_) async => Right(tPass));
    final result = await usecase(Params(number: tNumber));
    expect(result, Right(tPass));
    verify(mockPassRepository.getDisplayedPass(tNumber));
    verifyNoMoreInteractions(mockPassRepository);
  });
}