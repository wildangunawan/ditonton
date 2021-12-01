import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(Empty()) {
    on<OnChange>((event, emit) async {
      final query = event.query;

      emit(Loading());
      final result = await _searchMovies.execute(query);

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
