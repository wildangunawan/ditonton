import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTVs _getWatchlistTVs;

  WatchlistTvBloc(this._getWatchlistTVs) : super(Empty()) {
    on<LoadWatchlistTv>((event, emit) async {
      emit(Loading());
      final result = await _getWatchlistTVs.execute();

      result.fold(
        (failure) => emit(Error(failure.message)),
        (data) => emit(HasData(data)),
      );
    });
  }
}
