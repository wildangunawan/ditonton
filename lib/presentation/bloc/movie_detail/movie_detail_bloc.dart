import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(Empty()) {
    on<LoadMovieDetail>((event, emit) async {
      final id = event.id;
      
      emit(Loading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) => emit(Error(failure.message)), 
        (data) => emit(HasData(data))
      );
    });
  }
}
