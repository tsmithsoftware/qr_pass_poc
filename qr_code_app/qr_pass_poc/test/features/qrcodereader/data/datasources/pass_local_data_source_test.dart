
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/data/moor_database.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_local_data_source.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPassDatabase extends Mock implements PassDatabase {}
class MockPassRecord extends Mock implements PassRecord {}

void main() {
  PassValidationLocalDataSourceImpl dataSource;
  MockPassDatabase mockPassDatabase;

  MockPassRecord mockPassRecords = MockPassRecord();
  List<PassRecord> records = [mockPassRecords];
  Params storeIdParams = Params(
    pass: PassRequestModel(storeId: 1)
  );
  Params allParams = Params(
    pass: PassRequestModel(
      storeId: 1,
      pass: PassModel(
        passType: "LOA",
        visitorCompany: "BP",
        visitorName: "Bob",
        dateExpiry: "2020-10-20 12:00:00.000",
        passCategory: "A",
        passNumber: 1,
        dateValidFrom: "2020-10-20 12:00:00.000",
      )
    )
  );

  setUp(() {
    mockPassDatabase = MockPassDatabase();
    dataSource = PassValidationLocalDataSourceImpl(
      passDatabase: mockPassDatabase
    );
  });

  test('test local data source obtains records from local db if only store id is available', () async {
    when(mockPassRecords.storeId).thenReturn(1);
    when(mockPassRecords.passCategory).thenReturn("A");
    when(mockPassRecords.visitorCompany).thenReturn("BP");
    when(mockPassRecords.visitorName).thenReturn("Bob");
    when(mockPassRecords.passType).thenReturn("LOA");
    when(mockPassRecords.dateExpiry).thenReturn("2020-10-20 12:00:00.000");
    when(mockPassRecords.passNumber).thenReturn(1);
    when(mockPassDatabase.getAllRecords()).thenAnswer((realInvocation) async => records);
    PassValidationResponseModel resp = await dataSource.validatePass(storeIdParams);
    verify(mockPassDatabase.getAllRecords());
    assert(resp.isPassValid == true);
  });

  test('test local data source obtains records from local db using all available fields', () async {
    when(mockPassRecords.storeId).thenReturn(1);
    when(mockPassRecords.passCategory).thenReturn("A");
    when(mockPassRecords.visitorCompany).thenReturn("BP");
    when(mockPassRecords.visitorName).thenReturn("Bob");
    when(mockPassRecords.passType).thenReturn("LOA");
    when(mockPassRecords.dateExpiry).thenReturn("2020-10-20 12:00:00.000");
    when(mockPassRecords.passNumber).thenReturn(1);
    when(mockPassDatabase.getAllRecords()).thenAnswer((realInvocation) async => records);
    PassValidationResponseModel resp = await dataSource.validatePass(allParams);
    verify(mockPassDatabase.getAllRecords());
    verify(mockPassRecords.storeId);
    verify(mockPassRecords.passCategory);
    verify(mockPassRecords.visitorCompany);
    verify(mockPassRecords.visitorName);
    verify(mockPassRecords.passType);
    verify(mockPassRecords.dateExpiry);
    verify(mockPassRecords.passNumber);
    assert(resp.isPassValid == true);
  });
}