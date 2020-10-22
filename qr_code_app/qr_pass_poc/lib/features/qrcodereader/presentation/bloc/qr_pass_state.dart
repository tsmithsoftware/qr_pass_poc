
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_validation_response_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_validation_response_entity.dart';

@immutable
abstract class ValidateQrPassState extends Equatable {
  ValidateQrPassState([List props = const <dynamic>[]]) : super();
}

class Empty extends ValidateQrPassState {
  @override
  List<Object> get props => [];
}

class Loading extends ValidateQrPassState {
  @override
  List<Object> get props => [];
}

class Loaded extends ValidateQrPassState {
  final PassValidationResponseEntity responseModel;

  Loaded({@required this.responseModel}) : super([responseModel]);

  @override
  List<Object> get props => [responseModel];
}

class Error extends ValidateQrPassState {
  final Failure failure;

  Error({@required this.failure}) : super([failure]);

  @override
  List<Object> get props =>[failure];
}