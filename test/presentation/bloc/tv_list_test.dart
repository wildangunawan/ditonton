import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_test.mocks.dart';

@GenerateMocks([
  GetPopularTVs,
  GetTopRatedTVs,
  GetNowPlayingTVs,
])
void main() {
  late MockGetPopularTVs mockGetPopularTVs;
  late MockGetTopRatedTVs mockGetTopRatedTVs;
  late MockGetNowPlayingTVs mockGetNowPlayingTVs;
  late TvListBloc bloc;

  setUp(() {
    mockGetPopularTVs = MockGetPopularTVs();
    mockGetTopRatedTVs = MockGetTopRatedTVs();
    mockGetNowPlayingTVs = MockGetNowPlayingTVs();
    bloc = TvListBloc(mockGetNowPlayingTVs, mockGetPopularTVs, mockGetTopRatedTVs);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetPopularTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTVs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadNowPlayingTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetNowPlayingTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadNowPlayingTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTVs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );

  blocTest<TvListBloc, TvListState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetTopRatedTVs.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTVList()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTVs.execute());
    },
  );
}
