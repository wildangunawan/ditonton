part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
  
  @override
  List<Object> get props => [];
}

class Empty extends MovieDetailState {}
class Loading extends MovieDetailState {}

class Error extends MovieDetailState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends MovieDetailState {
  final MovieDetail data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}