import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc bloc;
  late MockGetWatchlistMovies mock;

  setUp(() {
    mock = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovie()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovie()),
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
