import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PassValidationResponseEntity extends Equatable {
  final bool isPassValid;

  PassValidationResponseEntity({@required this.isPassValid});

  @override
  List<Object> get props => [this.isPassValid];
}