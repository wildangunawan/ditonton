part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class Empty extends MovieDetailState {}

class Loading extends MovieDetailState {}

class HasData extends MovieDetailState {}

class Error extends MovieDetailState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class AddSuccess extends MovieDetailState {}

class RemoveSuccess extends MovieDetailState {}
