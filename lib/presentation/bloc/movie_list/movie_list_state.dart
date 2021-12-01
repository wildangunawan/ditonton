part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
  
  @override
  List<Object> get props => [];
}

class Empty extends MovieListState {}
class Loading extends MovieListState {}

class Error extends MovieListState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends MovieListState {
  final List<Movie> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}
