import 'package:equatable/equatable.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/pass_entity.dart';

class PassRequestEntity extends Equatable {
  final int storeId;
  final PassEntity pass;

  PassRequestEntity(this.storeId, this.pass);

  @override
  List<Object> get props => [this.storeId, this.pass];
}