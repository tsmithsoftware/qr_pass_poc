import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PassEntity extends Equatable {
  int passNumber;
  String dateValidFrom;
  String dateExpiry;
  String passType;
  String passCategory;
  String visitorName;
  String visitorCompany;

  PassEntity({
    @required this.passNumber,
  @required this.dateValidFrom,
  @required this.dateExpiry,
  @required this.passType,
  @required this.passCategory,
  @required this.visitorName,
  @required this.visitorCompany
});

  @override
  List<Object> get props => [
    this.passNumber,
    this.dateValidFrom,
    this.dateExpiry,
    this.passType,
    this.passCategory,
    this.visitorName,
    this.visitorCompany
  ];

}