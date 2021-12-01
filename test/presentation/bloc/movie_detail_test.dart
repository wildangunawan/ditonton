import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mock;

  setUp(() {
    mock = MockGetMovieDetail();
    bloc = MovieDetailBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mock.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute(1));
    },
  );
}
