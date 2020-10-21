import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/features/qrcodereader/data/models/pass_request_model.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_entity.dart';

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters
class NoParams extends Equatable {
  @override
  List<Object> get props =>[];
}
class Params extends Equatable {
  final int storeId;
  final PassRequestModel pass;

  Params({this.storeId, this.pass});

  @override
  List<Object> get props => [storeId, pass];

}