import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_entity.dart';

class PassModel extends PassEntity {

  DateTime validDateTime;
  DateTime expiryDateTime;

  PassModel({
    @required int passNumber,
    @required dateValidFrom,
    @required dateExpiry,
    @required passType,
    @required passCategory,
    @required visitorName,
    @required visitorCompany
  }): super(
    passNumber: passNumber,
    dateValidFrom: dateValidFrom,
    dateExpiry: dateExpiry,
    passType: passType,
    passCategory: passCategory,
    visitorName: visitorName,
    visitorCompany: visitorCompany
  ) {
    if (dateValidFrom != null) {
      this.validDateTime = DateTime.parse(dateValidFrom);
    }
    if (dateExpiry != null) {
      this.expiryDateTime = DateTime.parse(dateExpiry);
    }
  }

  static fromJson(Map<String, dynamic> jsonMap) {
    return PassModel(
      passNumber: jsonMap['passNumber'],
      dateValidFrom: jsonMap['dateValidFrom'],
      passCategory: jsonMap['passCategory'],
      dateExpiry: jsonMap['dateExpiry'],
      visitorName: jsonMap['visitorName'],
      visitorCompany: jsonMap['visitorCompany'],
      passType: jsonMap['passType']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passNumber': passNumber,
      'dateValidFrom': dateValidFrom,
      'dateExpiry': dateExpiry,
      'passType': passType,
      'passCategory': passCategory,
      'visitorName': visitorName,
      'visitorCompany': visitorCompany
    };
  }
}