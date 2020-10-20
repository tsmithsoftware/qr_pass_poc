import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/usecases/get_specific_displayed_pass.dart';
import 'package:qr_pass_poc/features/qrcodereader/presentation/bloc/bloc.dart';

class MockGetSpecificDisplayedPass extends Mock implements GetSpecificDisplayedPass {}

void main() {
  GetPassBloc bloc;
  MockGetSpecificDisplayedPass mockGetConcretePass;
  Params params;

  setUp(() {
    mockGetConcretePass = MockGetSpecificDisplayedPass();

    bloc = GetPassBloc(
      getSpecificDisplayedPass: mockGetConcretePass
    );

    params = Params(number: 1);
  });

  test('initialState should be GetPassInitial', () {
    // assert
    expect(bloc.state, equals(GetPassInitial()));
  });

  group('GetPass', (){
    final tPassId = 1;
    final tPass = DisplayedPass(
      passId: 1,
      category: "A",
      passNumber: 1,
      visitorImageLink: "doctor"
    );

    test('should get pass data from the GetPass use case', () async {
      //arrange
      when(mockGetConcretePass(params)).thenAnswer((_) async => Right(tPass));
      // act
      bloc.add(GetConcretePass(tPassId));
      // assert
      await untilCalled(mockGetConcretePass(any));
      verify(mockGetConcretePass(params));
      verifyNoMoreInteractions(mockGetConcretePass);
    });

    test('should emit [GetPassLoading, GetPassLoaded] on successful load', () async {
      //arrange
      when(mockGetConcretePass(params)).thenAnswer((_) async => Right(tPass));
      // assert
      final expected = [
        GetPassLoading(),
        GetPassLoaded(pass: tPass)
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetConcretePass(tPassId));
    });

    test('should emit [GetPassLoading, GetPassError] when load fails', (){
      // arrange
      when(mockGetConcretePass(params)).thenAnswer((_) async => Left(ServerFailure()));
      // assert
      final expected = [
        GetPassLoading(),
        GetPassError(ServerFailure())
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetConcretePass(tPassId));
    });

  });
}