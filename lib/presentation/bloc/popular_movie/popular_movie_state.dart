part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();
  
  @override
  List<Object> get props => [];
}

class Empty extends PopularMovieState {}
class Loading extends PopularMovieState {}

class Error extends PopularMovieState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends PopularMovieState {
  final List<Movie> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}