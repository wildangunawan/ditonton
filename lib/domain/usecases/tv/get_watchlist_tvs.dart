import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistMovies {
  final TVRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTVs();
  }
}
