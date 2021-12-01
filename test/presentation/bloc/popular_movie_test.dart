import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mock;
  late PopularMovieBloc bloc;

  setUp(() {
    mock = MockGetPopularMovies();
    bloc = PopularMovieBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularMovie()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularMovie()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );
}
