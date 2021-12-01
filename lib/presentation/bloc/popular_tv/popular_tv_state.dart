part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();
  
  @override
  List<Object> get props => [];
}

class Empty extends PopularTvState {}
class Loading extends PopularTvState {}

class Error extends PopularTvState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends PopularTvState {
  final List<TV> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}