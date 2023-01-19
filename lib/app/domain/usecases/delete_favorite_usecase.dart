import 'package:dartz/dartz.dart';
import '../erros.dart';

abstract class DeleteFavoriteUseCase{
  Future<Either<Failure,bool>> call(int id);
}