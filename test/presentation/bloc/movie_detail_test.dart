import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadMovieDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
      when(mockGetMovieRecommendations.execute(1))
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
      verify(mockGetMovieDetail.execute(1));
    },
  );

  test(
      'Should have isWatchlist == true and watchlistMessage == success message when watchlist is saved successfully',
      () async {
    // Arrange
    when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => Right(MovieDetailBloc.watchlistAddSuccessMessage));
    when(mockGetWatchListStatus.execute(testMovieDetail.id))
        .thenAnswer((_) async => true);

    // Act
    bloc.add(AddMovieToWatchlist(testMovieDetail));

    // Wait to make sure bloc is done processing
    final _ = await bloc.stream.first;

    // Assert
    expect(bloc.isWatchlist, true);
    expect(bloc.watchlistMessage, MovieDetailBloc.watchlistAddSuccessMessage);
  });

  test(
      'Should have isWatchlist == false and watchlistMessage == Failed when watchlist failed to be saved',
      () async {
    // Arrange
    when(mockSaveWatchlist.execute(testMovieDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
    when(mockGetWatchListStatus.execute(testMovieDetail.id))
        .thenAnswer((_) async => false);

    // Act
    bloc.add(AddMovieToWatchlist(testMovieDetail));

    // Wait to make sure bloc is done processing
    final _ = await bloc.stream.first;

    // Assert
    expect(bloc.isWatchlist, false);
    expect(bloc.watchlistMessage, "Failed");
  });

  test(
      'Should have isWatchlist == false and watchlistMessage == success message when watchlist is removed successfully',
      () async {
    // Arrange
    when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
        (_) async => Right(MovieDetailBloc.watchlistRemoveSuccessMessage));
    when(mockGetWatchListStatus.execute(testMovieDetail.id))
        .thenAnswer((_) async => false);

    // Act
    bloc.add(RemoveMovieFromWatchlist(testMovieDetail));

    // Wait to make sure bloc is done processing
    final _ = await bloc.stream.first;

    // Assert
    expect(bloc.isWatchlist, false);
    expect(
        bloc.watchlistMessage, MovieDetailBloc.watchlistRemoveSuccessMessage);
  });

  test(
      'Should have isWatchlist == true and watchlistMessage == Failed when watchlist failed to be removed',
      () async {
    // Arrange
    when(mockRemoveWatchlist.execute(testMovieDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
    when(mockGetWatchListStatus.execute(testMovieDetail.id))
        .thenAnswer((_) async => false);

    // Act
    bloc.add(RemoveMovieFromWatchlist(testMovieDetail));

    // Wait to make sure bloc is done processing
    final _ = await bloc.stream.first;

    // Assert
    expect(bloc.isWatchlist, true);
    expect(bloc.watchlistMessage, "Failed");
  });
}
