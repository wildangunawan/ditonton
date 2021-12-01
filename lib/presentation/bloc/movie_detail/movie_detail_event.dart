part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetail extends MovieDetailEvent {
  final int id;

  LoadMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class LoadMovieRecommendations extends MovieDetailEvent {
  final int id;

  LoadMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class LoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  AddMovieToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieFromWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  RemoveMovieFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
