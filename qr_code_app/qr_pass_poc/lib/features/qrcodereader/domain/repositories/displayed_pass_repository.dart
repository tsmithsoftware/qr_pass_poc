import 'package:dartz/dartz.dart';
import 'package:qr_pass_poc/core/error/failures.dart';
import 'package:qr_pass_poc/features/qrcodereader/domain/entities/displayed_pass.dart';

abstract class DisplayedPassRepository {
  Future<Either<Failure, DisplayedPass>> getDisplayedPass (int passId);
}