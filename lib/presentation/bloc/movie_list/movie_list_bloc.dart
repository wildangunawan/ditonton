import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies _getPopularMovies;
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;

  MovieListBloc(
    this._getPopularMovies,
    this._getNowPlayingMovies,
    this._getTopRatedMovies,
  ) : super(Empty()) {
    on<LoadMovieList>((event, emit) async {
      bool success = true;

      emit(Loading());
      final popular = await _getPopularMovies.execute();
      final nowPlaying = await _getNowPlayingMovies.execute();
      final topRated = await _getTopRatedMovies.execute();

      popular.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _popularMovies = r);

      nowPlaying.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _nowPlayingMovies = r);

      topRated.fold((l) {
        success = false;
        emit(Error(l.message));
      }, (r) => _topRatedMovies = r);

      if (success) emit(HasData());
    });
  }
}
