import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  List<Movie> _recommendations = [];
  List<Movie> get recommendations => _recommendations;

  bool _isWatchlist = false;
  bool get isWatchlist => _isWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  MovieDetailBloc(
    this._getMovieDetail,
    this._getMovieRecommendations,
    this._saveWatchlist,
    this._removeWatchlist,
    this._getWatchListStatus,
  ) : super(Empty()) {
    on<LoadMovieDetail>((event, emit) async {
      final id = event.id;
      bool success = true;

      emit(Loading());
      final result = await _getMovieDetail.execute(id);
      final recommendations = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        success = false;
        emit(Error(failure.message));
      }, (data) => _movie = data);

      recommendations.fold((failure) {
        success = false;
        emit(Error(failure.message));
      }, (data) => _recommendations = data);

      final watchlist = await _getWatchListStatus.execute(id);
      _isWatchlist = watchlist;

      if (success) emit(HasData());
    });

    on<AddMovieToWatchlist>((event, emit) async {
      bool success = true;

      final movie = event.movie;
      final result = await _saveWatchlist.execute(movie);

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

    on<RemoveMovieFromWatchlist>((event, emit) async {
      bool success = true;

      final movie = event.movie;
      final result = await _removeWatchlist.execute(movie);

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
