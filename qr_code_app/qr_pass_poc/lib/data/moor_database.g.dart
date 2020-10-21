// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps
class PassRecord extends DataClass implements Insertable<PassRecord> {
  final int id;
  final int storeId;
  final int passNumber;
  final String dateExpiry;
  final String passType;
  final String passCategory;
  final String visitorName;
  final String visitorCompany;
  PassRecord(
      {@required this.id,
      @required this.storeId,
      @required this.passNumber,
      @required this.dateExpiry,
      @required this.passType,
      @required this.passCategory,
      @required this.visitorName,
      @required this.visitorCompany});
  factory PassRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return PassRecord(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      storeId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}store_id']),
      passNumber: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}pass_number']),
      dateExpiry: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_expiry']),
      passType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pass_type']),
      passCategory: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}pass_category']),
      visitorName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_name']),
      visitorCompany: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}visitor_company']),
    );
  }
  factory PassRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return PassRecord(
      id: serializer.fromJson<int>(json['id']),
      storeId: serializer.fromJson<int>(json['storeId']),
      passNumber: serializer.fromJson<int>(json['passNumber']),
      dateExpiry: serializer.fromJson<String>(json['dateExpiry']),
      passType: serializer.fromJson<String>(json['passType']),
      passCategory: serializer.fromJson<String>(json['passCategory']),
      visitorName: serializer.fromJson<String>(json['visitorName']),
      visitorCompany: serializer.fromJson<String>(json['visitorCompany']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'storeId': serializer.toJson<int>(storeId),
      'passNumber': serializer.toJson<int>(passNumber),
      'dateExpiry': serializer.toJson<String>(dateExpiry),
      'passType': serializer.toJson<String>(passType),
      'passCategory': serializer.toJson<String>(passCategory),
      'visitorName': serializer.toJson<String>(visitorName),
      'visitorCompany': serializer.toJson<String>(visitorCompany),
    };
  }

  @override
  T createCompanion<T extends UpdateCompanion<PassRecord>>(bool nullToAbsent) {
    return PassRecordsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      storeId: storeId == null && nullToAbsent
          ? const Value.absent()
          : Value(storeId),
      passNumber: passNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(passNumber),
      dateExpiry: dateExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(dateExpiry),
      passType: passType == null && nullToAbsent
          ? const Value.absent()
          : Value(passType),
      passCategory: passCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(passCategory),
      visitorName: visitorName == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorName),
      visitorCompany: visitorCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(visitorCompany),
    ) as T;
  }

  PassRecord copyWith(
          {int id,
          int storeId,
          int passNumber,
          String dateExpiry,
          String passType,
          String passCategory,
          String visitorName,
          String visitorCompany}) =>
      PassRecord(
        id: id ?? this.id,
        storeId: storeId ?? this.storeId,
        passNumber: passNumber ?? this.passNumber,
        dateExpiry: dateExpiry ?? this.dateExpiry,
        passType: passType ?? this.passType,
        passCategory: passCategory ?? this.passCategory,
        visitorName: visitorName ?? this.visitorName,
        visitorCompany: visitorCompany ?? this.visitorCompany,
      );
  @override
  String toString() {
    return (StringBuffer('PassRecord(')
          ..write('id: $id, ')
          ..write('storeId: $storeId, ')
          ..write('passNumber: $passNumber, ')
          ..write('dateExpiry: $dateExpiry, ')
          ..write('passType: $passType, ')
          ..write('passCategory: $passCategory, ')
          ..write('visitorName: $visitorName, ')
          ..write('visitorCompany: $visitorCompany')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          storeId.hashCode,
          $mrjc(
              passNumber.hashCode,
              $mrjc(
                  dateExpiry.hashCode,
                  $mrjc(
                      passType.hashCode,
                      $mrjc(
                          passCategory.hashCode,
                          $mrjc(visitorName.hashCode,
                              visitorCompany.hashCode))))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is PassRecord &&
          other.id == id &&
          other.storeId == storeId &&
          other.passNumber == passNumber &&
          other.dateExpiry == dateExpiry &&
          other.passType == passType &&
          other.passCategory == passCategory &&
          other.visitorName == visitorName &&
          other.visitorCompany == visitorCompany);
}

class PassRecordsCompanion extends UpdateCompanion<PassRecord> {
  final Value<int> id;
  final Value<int> storeId;
  final Value<int> passNumber;
  final Value<String> dateExpiry;
  final Value<String> passType;
  final Value<String> passCategory;
  final Value<String> visitorName;
  final Value<String> visitorCompany;
  const PassRecordsCompanion({
    this.id = const Value.absent(),
    this.storeId = const Value.absent(),
    this.passNumber = const Value.absent(),
    this.dateExpiry = const Value.absent(),
    this.passType = const Value.absent(),
    this.passCategory = const Value.absent(),
    this.visitorName = const Value.absent(),
    this.visitorCompany = const Value.absent(),
  });
  PassRecordsCompanion copyWith(
      {Value<int> id,
      Value<int> storeId,
      Value<int> passNumber,
      Value<String> dateExpiry,
      Value<String> passType,
      Value<String> passCategory,
      Value<String> visitorName,
      Value<String> visitorCompany}) {
    return PassRecordsCompanion(
      id: id ?? this.id,
      storeId: storeId ?? this.storeId,
      passNumber: passNumber ?? this.passNumber,
      dateExpiry: dateExpiry ?? this.dateExpiry,
      passType: passType ?? this.passType,
      passCategory: passCategory ?? this.passCategory,
      visitorName: visitorName ?? this.visitorName,
      visitorCompany: visitorCompany ?? this.visitorCompany,
    );
  }
}

class $PassRecordsTable extends PassRecords
    with TableInfo<$PassRecordsTable, PassRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $PassRecordsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _storeIdMeta = const VerificationMeta('storeId');
  GeneratedIntColumn _storeId;
  @override
  GeneratedIntColumn get storeId => _storeId ??= _constructStoreId();
  GeneratedIntColumn _constructStoreId() {
    return GeneratedIntColumn(
      'store_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passNumberMeta = const VerificationMeta('passNumber');
  GeneratedIntColumn _passNumber;
  @override
  GeneratedIntColumn get passNumber => _passNumber ??= _constructPassNumber();
  GeneratedIntColumn _constructPassNumber() {
    return GeneratedIntColumn(
      'pass_number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateExpiryMeta = const VerificationMeta('dateExpiry');
  GeneratedTextColumn _dateExpiry;
  @override
  GeneratedTextColumn get dateExpiry => _dateExpiry ??= _constructDateExpiry();
  GeneratedTextColumn _constructDateExpiry() {
    return GeneratedTextColumn('date_expiry', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _passTypeMeta = const VerificationMeta('passType');
  GeneratedTextColumn _passType;
  @override
  GeneratedTextColumn get passType => _passType ??= _constructPassType();
  GeneratedTextColumn _constructPassType() {
    return GeneratedTextColumn('pass_type', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _passCategoryMeta =
      const VerificationMeta('passCategory');
  GeneratedTextColumn _passCategory;
  @override
  GeneratedTextColumn get passCategory =>
      _passCategory ??= _constructPassCategory();
  GeneratedTextColumn _constructPassCategory() {
    return GeneratedTextColumn('pass_category', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _visitorNameMeta =
      const VerificationMeta('visitorName');
  GeneratedTextColumn _visitorName;
  @override
  GeneratedTextColumn get visitorName =>
      _visitorName ??= _constructVisitorName();
  GeneratedTextColumn _constructVisitorName() {
    return GeneratedTextColumn('visitor_name', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  final VerificationMeta _visitorCompanyMeta =
      const VerificationMeta('visitorCompany');
  GeneratedTextColumn _visitorCompany;
  @override
  GeneratedTextColumn get visitorCompany =>
      _visitorCompany ??= _constructVisitorCompany();
  GeneratedTextColumn _constructVisitorCompany() {
    return GeneratedTextColumn('visitor_company', $tableName, false,
        minTextLength: 1, maxTextLength: 50);
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        storeId,
        passNumber,
        dateExpiry,
        passType,
        passCategory,
        visitorName,
        visitorCompany
      ];
  @override
  $PassRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'pass_records';
  @override
  final String actualTableName = 'pass_records';
  @override
  VerificationContext validateIntegrity(PassRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.storeId.present) {
      context.handle(_storeIdMeta,
          storeId.isAcceptableValue(d.storeId.value, _storeIdMeta));
    } else if (storeId.isRequired && isInserting) {
      context.missing(_storeIdMeta);
    }
    if (d.passNumber.present) {
      context.handle(_passNumberMeta,
          passNumber.isAcceptableValue(d.passNumber.value, _passNumberMeta));
    } else if (passNumber.isRequired && isInserting) {
      context.missing(_passNumberMeta);
    }
    if (d.dateExpiry.present) {
      context.handle(_dateExpiryMeta,
          dateExpiry.isAcceptableValue(d.dateExpiry.value, _dateExpiryMeta));
    } else if (dateExpiry.isRequired && isInserting) {
      context.missing(_dateExpiryMeta);
    }
    if (d.passType.present) {
      context.handle(_passTypeMeta,
          passType.isAcceptableValue(d.passType.value, _passTypeMeta));
    } else if (passType.isRequired && isInserting) {
      context.missing(_passTypeMeta);
    }
    if (d.passCategory.present) {
      context.handle(
          _passCategoryMeta,
          passCategory.isAcceptableValue(
              d.passCategory.value, _passCategoryMeta));
    } else if (passCategory.isRequired && isInserting) {
      context.missing(_passCategoryMeta);
    }
    if (d.visitorName.present) {
      context.handle(_visitorNameMeta,
          visitorName.isAcceptableValue(d.visitorName.value, _visitorNameMeta));
    } else if (visitorName.isRequired && isInserting) {
      context.missing(_visitorNameMeta);
    }
    if (d.visitorCompany.present) {
      context.handle(
          _visitorCompanyMeta,
          visitorCompany.isAcceptableValue(
              d.visitorCompany.value, _visitorCompanyMeta));
    } else if (visitorCompany.isRequired && isInserting) {
      context.missing(_visitorCompanyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PassRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return PassRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(PassRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.storeId.present) {
      map['store_id'] = Variable<int, IntType>(d.storeId.value);
    }
    if (d.passNumber.present) {
      map['pass_number'] = Variable<int, IntType>(d.passNumber.value);
    }
    if (d.dateExpiry.present) {
      map['date_expiry'] = Variable<String, StringType>(d.dateExpiry.value);
    }
    if (d.passType.present) {
      map['pass_type'] = Variable<String, StringType>(d.passType.value);
    }
    if (d.passCategory.present) {
      map['pass_category'] = Variable<String, StringType>(d.passCategory.value);
    }
    if (d.visitorName.present) {
      map['visitor_name'] = Variable<String, StringType>(d.visitorName.value);
    }
    if (d.visitorCompany.present) {
      map['visitor_company'] =
          Variable<String, StringType>(d.visitorCompany.value);
    }
    return map;
  }

  @override
  $PassRecordsTable createAlias(String alias) {
    return $PassRecordsTable(_db, alias);
  }
}

abstract class _$PassDatabase extends GeneratedDatabase {
  _$PassDatabase(QueryExecutor e)
      : super(const SqlTypeSystem.withDefaults(), e);
  $PassRecordsTable _passRecords;
  $PassRecordsTable get passRecords => _passRecords ??= $PassRecordsTable(this);
  @override
  List<TableInfo> get allTables => [passRecords];
}
