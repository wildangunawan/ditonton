part of 'top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();
  
  @override
  List<Object> get props => [];
}

class Empty extends TopRatedMovieState {}
class Loading extends TopRatedMovieState {}

class Error extends TopRatedMovieState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends TopRatedMovieState {
  final List<Movie> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}