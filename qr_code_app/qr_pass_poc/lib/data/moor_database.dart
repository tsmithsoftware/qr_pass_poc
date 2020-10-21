import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class PassRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get storeId => integer()();
  IntColumn get passNumber => integer()();
  TextColumn get dateExpiry => text().withLength(min: 1, max: 50)();
  TextColumn get passType => text().withLength(min: 1, max: 50)();
  TextColumn get passCategory => text().withLength(min: 1, max: 50)();
  TextColumn get visitorName => text().withLength(min: 1, max: 50)();
  TextColumn get visitorCompany => text().withLength(min: 1, max: 50)();
}

@UseMoor(tables: [PassRecords])
class PassDatabase extends _$PassDatabase {
  PassDatabase() : super ( (FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite', logStatements: true)) );

  @override
  int get schemaVersion => 1;

  Future<List<PassRecord>> getAllRecords() => select(passRecords).get();

  Stream<List<PassRecord>> watchAllRecords() => select(passRecords).watch();

  Future insertPassRecord(PassRecord passRecord) => into(passRecords).insert(passRecord);

  Future updatePassRecord(PassRecord passRecord) => update(passRecords).replace(passRecord);

  Future deletePassRecord(PassRecord passRecord) => delete(passRecords).delete(passRecord);
}