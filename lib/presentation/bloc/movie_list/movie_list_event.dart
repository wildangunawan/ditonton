part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class LoadPopularMovieList extends MovieListEvent {}
class LoadNowPlayingMovieList extends MovieListEvent {}
class LoadTopRatedMovieList extends MovieListEvent {}
