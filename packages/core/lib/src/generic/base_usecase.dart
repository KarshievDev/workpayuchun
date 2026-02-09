import 'package:fpdart/fpdart.dart';
import 'package:core/src/failure/failure.dart';

abstract class BaseUseCase<T>{
  Future<Either<Failure, T>> call();
}