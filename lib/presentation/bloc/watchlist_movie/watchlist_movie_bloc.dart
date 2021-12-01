import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._getWatchlistMovies) : super(Empty()) {
    on<LoadWatchlistMovie>((event, emit) async {
      emit(Loading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) => emit(Error(failure.message)), 
        (data) => emit(HasData(data))
      );
    });
  }
}
