import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail _getTvDetail;
  final GetTVRecommendations _getTvRecommendations;
  final SaveTVWatchlist _saveTvWatchlist;
  final RemoveTVWatchlist _removeTvWatchlist;
  final GetTVWatchListStatus _getTvWatchListStatus;

  late TVDetail _tv;
  TVDetail get tv => _tv;

  List<TV> _recommendations = [];
  List<TV> get recommendations => _recommendations;

  bool _isWatchlist = false;
  bool get isWatchlist => _isWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  TvDetailBloc(
      this._getTvDetail,
      this._getTvRecommendations,
      this._saveTvWatchlist,
      this._removeTvWatchlist,
      this._getTvWatchListStatus)
      : super(Empty()) {
    on<LoadTvDetail>((event, emit) async {
      final id = event.id;
      bool success = true;

      emit(Loading());
      final result = await _getTvDetail.execute(id);
      final recommendations = await _getTvRecommendations.execute(id);

      result.fold((failure) {
        success = false;
        emit(Error(failure.message));
      }, (data) => _tv = data);

      recommendations.fold((failure) {
        success = false;
        emit(Error(failure.message));
      }, (data) => _recommendations = data);

      final watchlist = await _getTvWatchListStatus.execute(id);
      _isWatchlist = watchlist;

      if (success) emit(HasData());
    });

    on<AddTvToWatchlist>((event, emit) async {
      bool success = true;

      final tv = event.tv;
      final result = await _saveTvWatchlist.execute(tv);

      result.fold(
        (failure) => {success = false, _watchlistMessage = failure.message},
        (successMessage) => _watchlistMessage = successMessage,
      );

      if (success)
        _isWatchlist = true;
      else
        _isWatchlist = false;

      emit(AddSuccess());
    });

    on<RemoveTvFromWatchlist>((event, emit) async {
      bool success = true;

      final tv = event.tv;
      final result = await _removeTvWatchlist.execute(tv);

      result.fold(
        (failure) => {success = false, _watchlistMessage = failure.message},
        (successMessage) => _watchlistMessage = successMessage,
      );

      if (success)
        _isWatchlist = false;
      else
        _isWatchlist = true;

      emit(RemoveSuccess());
    });
  }
}
