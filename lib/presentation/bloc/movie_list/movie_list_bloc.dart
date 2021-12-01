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
    on<LoadPopularMovieList>((event, emit) async {
      emit(Loading());
      final result = await _getPopularMovies.execute();

      result.fold((l) => emit(Error(l.message)), (r) {
        emit(HasData());
        _popularMovies = r;
      });
    });
    
    on<LoadNowPlayingMovieList>((event, emit) async {
      emit(Loading());
      final result = await _getNowPlayingMovies.execute();

      result.fold((l) => emit(Error(l.message)), (r) {
        emit(HasData());
        _nowPlayingMovies = r;
      });
    });
    
    on<LoadTopRatedMovieList>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedMovies.execute();

      result.fold((l) => emit(Error(l.message)), (r) {
        emit(HasData());
        _topRatedMovies = r;
      });
    });
  }
}
