import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DisplayedPass extends Equatable {
  final int passId;
  final String visitorImageLink;
  final String category;
  final int passNumber;
  final String visitorName;

  DisplayedPass({
    @required this.passId,
    @required this.visitorImageLink,
    @required this.category,
    @required this.passNumber,
    @required this.visitorName
  });

  @override
  List<Object> get props =>
      [passId, visitorImageLink, category, passNumber, visitorName];

  @override
  bool get stringify => true;
}