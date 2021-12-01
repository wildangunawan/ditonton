part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();
  
  @override
  List<Object> get props => [];
}

class Empty extends TopRatedTvState {}
class Loading extends TopRatedTvState {}

class Error extends TopRatedTvState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends TopRatedTvState {
  final List<TV> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}