part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}

class OnChange extends SearchTvEvent {
  final String query;

  OnChange(this.query);

  @override
  List<Object> get props => [query];
}