part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
  
  @override
  List<Object> get props => [];
}

class Empty extends WatchlistMovieState {}
class Loading extends WatchlistMovieState {}

class Error extends WatchlistMovieState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends WatchlistMovieState {
  final List<Movie> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}