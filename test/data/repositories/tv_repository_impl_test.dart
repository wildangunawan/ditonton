import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/created_by.dart';
import 'package:ditonton/data/models/tv/episode_to_air.dart';
import 'package:ditonton/data/models/tv/network.dart';
import 'package:ditonton/data/models/tv/production_company.dart';
import 'package:ditonton/data/models/tv/production_country.dart';
import 'package:ditonton/data/models/tv/season.dart';
import 'package:ditonton/data/models/tv/spoken_language.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVModel = TVModel(
    backdropPath: "/bSLURECWQ3xVhEpmFag6bznbAMx.jpg",
    firstAirDate: DateTime.now(),
    genreIds: [18],
    id: 3475,
    name: "The L Word",
    originCountry: ["US", "CA"],
    originalLanguage: "en",
    originalName: "The L Word",
    overview:
        "A group of lesbian friends struggle with romance and careers in Los Angeles.",
    popularity: 45.582,
    posterPath: "/cRuye5mp69wfnsbfgJiBFQJQo1e.jpg",
    voteAverage: 7.7,
    voteCount: 598
  );

  final tTV = TV(
    backdropPath: "/bSLURECWQ3xVhEpmFag6bznbAMx.jpg",
    firstAirDate: DateTime.now(),
    genreIds: [18],
    id: 3475,
    name: "The L Word",
    originCountry: ["US", "CA"],
    originalLanguage: "en",
    originalName: "The L Word",
    overview:
        "A group of lesbian friends struggle with romance and careers in Los Angeles.",
    popularity: 45.582,
    posterPath: "/cRuye5mp69wfnsbfgJiBFQJQo1e.jpg",
    voteAverage: 7.7,
    voteCount: 598
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('Now Playing TVs', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getNowPlayingTVs();

      // assert
      verify(mockRemoteDataSource.getNowPlayingTVs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTVs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTVs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTVs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTVs();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTVs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TVs', () {
    test('should return TV list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TVs', () {
    test('should return TV list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TV Detail', () {
    final tId = 1;
    final tTVResponse = TVDetailModel(
      backdropPath: "/bSLURECWQ3xVhEpmFag6bznbAMx.jpg",
    createdBy: [CreatedByModel(id: 4749, creditId: "525751bd760ee36aaa1cbea7", name: "Ilene Chaiken", gender: 1, profilePath: null)],
    episodeRunTime: [50],
    firstAirDate: DateTime.parse("2004-01-18"),
    genres: [GenreModel(id: 18, name: "Drama")],
    homepage: "http://www.sho.com/the-l-word",
    id: 3475,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse("2009-03-08"),
    lastEpisodeToAir: EpisodeToAirModel(airDate: DateTime.parse("2009-03-08"), episodeNumber: 8, id: 250819, name: "Last Word", overview: "In the final episode of the series, what starts out as a celebration of friendship quickly ends in a web of betrayal and deceit; the girls find themselves in the slammer with Sergeant Duffy; and the investigation into ? ? death begins…", productionCode: "", seasonNumber: 6, stillPath: "/itBBKWi7CAsm7m7hJqe1VmNvYDk.jpg", voteAverage: 5, voteCount: 1),
    name: "The L Word",
    nextEpisodeToAir: null,
    networks: [NetworkModel(name: "Showtime", id: 67, logoPath: "/Allse9kbjiP6ExaQrnSpIhkurEi.png", originCountry: "US")],
    numberOfEpisodes: 71,
    numberOfSeasons: 6,
    originCountry: ["CA", "US"],
    originalLanguage: "en",
    originalName: "The L Word",
    overview: "A group of lesbian friends struggle with romance and careers in Los Angeles.",
    popularity: 45.582,
    posterPath: "/cRuye5mp69wfnsbfgJiBFQJQo1e.jpg",
    productionCompanies: [ProductionCompanyModel(id: 81151, logoPath: null, name: "Coast Mountain Films Studios", originCountry: "")],
    productionCountries: [ProductionCountryModel(iso31661: "US", name: "United States of America")],
    seasons: [SeasonModel(id: 10609, name: "Specials", overview: "", airDate: null, episodeCount: 4, posterPath: null, seasonNumber: 0)],
    spokenLanguages: [SpokenLanguageModel(englishName: "English", iso6391: "en", name: "English")],
    status: "Canceled",
    tagline: "",
    type: "Scripted",
    voteAverage: 7.7,
    voteCount: 598
    );

    test(
        'should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => tTVResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTVDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTVList = <TVModel>[];
    final tId = 1;

    test('should return data (TV list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TVs', () {
    final tQuery = 'The L Word';

    test('should return TV list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVs(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVs(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(TVTable.fromEntity(testTVDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(TVTable.fromEntity(testTVDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(TVTable.fromEntity(testTVDetail)))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(TVTable.fromEntity(testTVDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TVs', () {
    test('should return list of TVs', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTVs())
          .thenAnswer((_) async => [testTVTable]);
      // act
      final result = await repository.getWatchlistTVs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });
}
