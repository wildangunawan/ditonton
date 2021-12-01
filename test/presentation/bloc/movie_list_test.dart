import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_list_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
  GetTopRatedMovies,
  GetNowPlayingMovies,
])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieListBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    bloc = MovieListBloc(
        mockGetPopularMovies, mockGetNowPlayingMovies, mockGetTopRatedMovies);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
