// ignore_for_file: avoid_types_as_parameter_names

import 'package:corporate_threat_detection/core/either/either.dart';
import 'package:corporate_threat_detection/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Class to handle when useCase don't need params
class NoParams {}
