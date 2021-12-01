import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies) : super(Empty()) {
    on<LoadTopRatedMovie>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedMovies.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
