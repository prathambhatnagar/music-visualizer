import 'package:dartz/dartz.dart';
import 'package:music_visualizer/core/failure/failure.dart';

abstract class UseCase<ReturnType, Param> {
  Future<Either<Failure, ReturnType>> call(Param param);
}

class NoParam {}
