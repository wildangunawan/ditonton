import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/http.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() =>
      MovieDetailBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => MovieListBloc(locator(), locator(), locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(locator()));

  locator.registerFactory(() =>
      TvDetailBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerFactory(() => TvListBloc(locator(), locator(), locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => SearchTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTVs(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => GetTVWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
    () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpWithSSLPinning.client);
}
