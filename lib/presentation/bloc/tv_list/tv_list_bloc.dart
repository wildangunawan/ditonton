import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetPopularTVs _getPopularTVs;
  final GetNowPlayingTVs _getNowPlayingTVs;
  final GetTopRatedTVs _getTopRatedTVs;

  TvListBloc(this._getNowPlayingTVs, this._getPopularTVs, this._getTopRatedTVs)
      : super(Empty()) {
    on<LoadPopularTVList>((event, emit) async {
      emit(Loading());
      final result = await _getPopularTVs.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
    
    on<LoadNowPlayingTVList>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingTVs.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
    
    on<LoadTopRatedTVList>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedTVs.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
