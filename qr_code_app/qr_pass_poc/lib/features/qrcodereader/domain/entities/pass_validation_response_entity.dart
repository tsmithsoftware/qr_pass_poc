import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_entity.dart';

class PassValidationResponseEntity extends Equatable {
  final bool isPassValid;
  final PassEntity pass;

  PassValidationResponseEntity({@required this.isPassValid, @required this.pass});

  @override
  List<Object> get props => [this.isPassValid, this.pass];
}