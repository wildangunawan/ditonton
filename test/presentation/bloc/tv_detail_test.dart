import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetTVWatchListStatus,
  SaveTVWatchlist,
  RemoveTVWatchlist
])
void main() {
  late TvDetailBloc bloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetTVWatchListStatus mockGetTVWatchListStatus;
  late MockSaveTVWatchlist mockSaveTVWatchlist;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetTVWatchListStatus = MockGetTVWatchListStatus();
    mockSaveTVWatchlist = MockSaveTVWatchlist();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    bloc = TvDetailBloc(
      mockGetTVDetail,
      mockGetTVRecommendations,
      mockSaveTVWatchlist,
      mockRemoveTVWatchlist,
      mockGetTVWatchListStatus,
    );
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetTVDetail.execute(1))
          .thenAnswer((_) async => Right(testTVDetail));
      when(mockGetTVRecommendations.execute(1))
          .thenAnswer((_) async => Right(testTVList));
      when(mockGetTVWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTvDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetTVDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetTVRecommendations.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetTVWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTvDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Success] when watchlist saved successfully',
    build: () {
      when(mockSaveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTVWatchListStatus.execute(1))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddTvToWatchlist(testTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Success('Success'),
    ],
    verify: (bloc) {
      verify(mockSaveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when watchlist failed to be saved',
    build: () {
      when(mockSaveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTVWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(AddTvToWatchlist(testTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Failed'),
    ],
    verify: (bloc) {
      verify(mockSaveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Success] when watchlist removed successfully',
    build: () {
      when(mockRemoveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTVWatchListStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Success('Success'),
    ],
    verify: (bloc) {
      verify(mockRemoveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when watchlist failed to be removed',
    build: () {
      when(mockRemoveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTVWatchListStatus.execute(testTVDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveTvFromWatchlist(testTVDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Failed'),
    ],
    verify: (bloc) {
      verify(mockRemoveTVWatchlist.execute(testTVDetail));
    },
  );
}
