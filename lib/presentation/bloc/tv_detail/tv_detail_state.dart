part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();
  
  @override
  List<Object> get props => [];
}

class Empty extends TvDetailState {}
class Loading extends TvDetailState {}

class Error extends TvDetailState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends TvDetailState {
  final TVDetail data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}