import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:qr_pass_poc/core/usecases/usecase.dart';

@immutable
abstract class QrPassEvent extends Equatable {
  QrPassEvent([List props = const <dynamic>[]]) : super();
}

class ValidateQrPass extends QrPassEvent {
  final Params params;

  ValidateQrPass(this.params) : super([params]);

  @override
  List<Object> get props => [params];
}