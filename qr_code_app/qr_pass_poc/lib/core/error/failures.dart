
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure([List properties = const <dynamic>[]]) : super();

  String message;
  int code;

  @override
  List<Object> get props => [message, code];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({int code, String message}) : super([code, message]) {
    this.code = code;
    this.message = message;
  }
}

class ConnectionFailure extends Failure {
  String message = "Device is not connected to the internet.";
}