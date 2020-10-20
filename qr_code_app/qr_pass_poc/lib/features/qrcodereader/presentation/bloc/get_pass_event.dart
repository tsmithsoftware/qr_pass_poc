import 'package:equatable/equatable.dart';

abstract class GetPassEvent extends Equatable {
  const GetPassEvent();
}

class GetConcretePass extends GetPassEvent {
  final int passId;

  GetConcretePass(this.passId);

  @override
  List<Object> get props => [passId];
}

