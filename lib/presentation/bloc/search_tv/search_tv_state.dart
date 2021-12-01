part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();
  
  @override
  List<Object> get props => [];
}

class Empty extends SearchTvState {}
class Loading extends SearchTvState {}

class Error extends SearchTvState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends SearchTvState {
  final List<TV> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}