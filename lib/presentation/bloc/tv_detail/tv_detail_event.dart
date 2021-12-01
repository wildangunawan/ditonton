part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadTvDetail extends TvDetailEvent {
  final int id;

  LoadTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class LoadTvRecommendations extends TvDetailEvent {
  final int id;

  LoadTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class AddTvToWatchlist extends TvDetailEvent {
  final TVDetail tv;

  AddTvToWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveTvFromWatchlist extends TvDetailEvent {
  final TVDetail tv;

  RemoveTvFromWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistStatus extends TvDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
