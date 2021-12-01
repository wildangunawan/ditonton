part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();
  
  @override
  List<Object> get props => [];
}

class Empty extends TvListState {}
class Loading extends TvListState {}

class Error extends TvListState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends TvListState {
  final List<TV> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}