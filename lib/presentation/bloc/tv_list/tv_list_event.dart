part of 'tv_list_bloc.dart';

abstract class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class LoadPopularTVList extends TvListEvent {}
class LoadNowPlayingTVList extends TvListEvent {}
class LoadTopRatedTVList extends TvListEvent {}
