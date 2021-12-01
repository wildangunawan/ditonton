part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();
  
  @override
  List<Object> get props => [];
}

class Empty extends SearchMovieState {}
class Loading extends SearchMovieState {}

class Error extends SearchMovieState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends SearchMovieState {
  final List<Movie> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}