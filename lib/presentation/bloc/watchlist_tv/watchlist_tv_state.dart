part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();
  
  @override
  List<Object> get props => [];
}

class Empty extends WatchlistTvState {}
class Loading extends WatchlistTvState {}

class Error extends WatchlistTvState {
  final String message;

  Error(this.message);

  @override
  List<Object> get props => [message];
}

class HasData extends WatchlistTvState {
  final List<TV> data;

  HasData(this.data);

  @override
  List<Object> get props => [data];
}
