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

  TvDetailBloc(
    this._getTvDetail, 
    this._getTvRecommendations,
    this._saveTvWatchlist, 
    this._removeTvWatchlist, 
    this._getTvWatchListStatus
  ) : super(Empty()) {
    on<LoadTvDetail>((event, emit) async {
      final id = event.id;

      emit(Loading());
      final result = await _getTvDetail.execute(id);

      result.fold(
          (failure) => emit(Error(failure.message)), 
          (data) {
            emit(HasData());
            _tv = data;
          });
    });

    on<LoadTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(Loading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
          (failure) => emit(Error(failure.message)), 
          (data) {
            emit(HasData());
            _recommendations = data;
          });
    });

    on<AddTvToWatchlist>((event, emit) async {
      final tv = event.tv;

      emit(Loading());
      final result = await _saveTvWatchlist.execute(tv);

      await result.fold(
        (failure) async {
          emit(Error(failure.message));
        },
        (successMessage) async {
          emit(Success(successMessage));
        },
      );
    });

    on<RemoveTvFromWatchlist>((event, emit) async {
      final tv = event.tv;

      emit(Loading());
      final result = await _removeTvWatchlist.execute(tv);

      await result.fold(
        (failure) async {
          emit(Error(failure.message));
        },
        (successMessage) async {
          emit(Success(successMessage));
        },
      );
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final tv = event.id;
      final result = await _getTvWatchListStatus.execute(tv);
      _isWatchlist = result;
    });
  }
}
