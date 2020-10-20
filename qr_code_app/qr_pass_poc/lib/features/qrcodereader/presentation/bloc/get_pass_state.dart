
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_pass_poc/core/error/error_state.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';

abstract class GetPassState extends Equatable {
  const GetPassState();

  @override
  List<Object> get props => [];
}

class GetPassInitial extends GetPassState {}

class GetPassLoading extends GetPassState {}

class GetPassLoaded extends GetPassState {
  final DisplayedPass pass;

  GetPassLoaded({@required this.pass}) : assert( pass != null);
}

class GetPassError extends GetPassState implements ErrorState{

  @override
  Failure failure;

  GetPassError(this.failure);

  @override
  List<Object> get props => [failure];

}