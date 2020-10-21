
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';
import 'package:qr_pass_poc/data/moor_database.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/datasources/pass_validation_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockPassDatabase extends Mock implements PassDatabase {}
class MockPassRecord extends Mock implements PassRecord {}

void main() {
  PassValidationLocalDataSourceImpl dataSource;
  MockPassDatabase mockPassDatabase;

  MockPassRecord mockPassRecords = MockPassRecord();
  List<PassRecord> records = [mockPassRecords];
  Params params = Params();

  setUp(() {
    mockPassDatabase = MockPassDatabase();
    dataSource = PassValidationLocalDataSourceImpl(
      passDatabase: mockPassDatabase
    );
  });

  test('test local data source obtains records from local db', (){
    when(mockPassDatabase.getAllRecords()).thenAnswer((realInvocation) async => records);
    dataSource.validatePass(params);
    verify(mockPassDatabase.getAllRecords());
  });
}