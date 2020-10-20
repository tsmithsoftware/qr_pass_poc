
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PassValidation extends Equatable {
  final int passId;

  PassValidation({
    @required this.passId
  });

  @override
  List<Object> get props =>
      [passId];

  @override
  bool get stringify => true;
}