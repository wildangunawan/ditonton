import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mock;
  late TopRatedMovieBloc bloc;

  setUp(() {
    mock = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedMovie()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedMovie()),
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
