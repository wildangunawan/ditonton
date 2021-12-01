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

  List<TV> _popularTVs = [];
  List<TV> _nowPlayingTVs = [];
  List<TV> _topRatedTVs = [];

  List<TV> get popularTVs => _popularTVs;
  List<TV> get nowPlayingTVs => _nowPlayingTVs;
  List<TV> get topRatedTVs => _topRatedTVs;

  TvListBloc(this._getNowPlayingTVs, this._getPopularTVs, this._getTopRatedTVs)
      : super(Empty()) {
    on<LoadTVList>((event, emit) async {
      bool success = true;

      emit(Loading());
      final popular = await _getPopularTVs.execute();
      final nowPlaying = await _getNowPlayingTVs.execute();
      final topRated = await _getTopRatedTVs.execute();

      popular.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _popularTVs = r);

      nowPlaying.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _nowPlayingTVs = r);

      topRated.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _topRatedTVs = r);

      if (success) emit(HasData());
    });
  }
}
