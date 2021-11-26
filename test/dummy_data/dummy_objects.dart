import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv/created_by.dart';
import 'package:ditonton/domain/entities/tv/episode_to_air.dart';
import 'package:ditonton/domain/entities/tv/network.dart';
import 'package:ditonton/domain/entities/tv/production_company.dart';
import 'package:ditonton/domain/entities/tv/production_country.dart';
import 'package:ditonton/domain/entities/tv/season.dart';
import 'package:ditonton/domain/entities/tv/spoken_language.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTV = TV(
    backdropPath: "/bSLURECWQ3xVhEpmFag6bznbAMx.jpg",
    firstAirDate: DateTime.parse("2004-01-18"),
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
    voteCount: 598);

final testTVList = [testTV];

final testTVDetail = TVDetail(
    backdropPath: "/bSLURECWQ3xVhEpmFag6bznbAMx.jpg",
    createdBy: [CreatedBy(id: 4749, creditId: "525751bd760ee36aaa1cbea7", name: "Ilene Chaiken", gender: 1, profilePath: null)],
    episodeRunTime: [50],
    firstAirDate: DateTime.parse("2004-01-18"),
    genres: [Genre(id: 18, name: "Drama")],
    homepage: "http://www.sho.com/the-l-word",
    id: 3475,
    inProduction: false,
    languages: ["en"],
    lastAirDate: DateTime.parse("2009-03-08"),
    lastEpisodeToAir: EpisodeToAir(airDate: DateTime.parse("2009-03-08"), episodeNumber: 8, id: 250819, name: "Last Word", overview: "In the final episode of the series, what starts out as a celebration of friendship quickly ends in a web of betrayal and deceit; the girls find themselves in the slammer with Sergeant Duffy; and the investigation into ? ? death begins…", productionCode: "", seasonNumber: 6, stillPath: "/itBBKWi7CAsm7m7hJqe1VmNvYDk.jpg", voteAverage: 5, voteCount: 1),
    name: "The L Word",
    nextEpisodeToAir: null,
    networks: [Network(name: "Showtime", id: 67, logoPath: "/Allse9kbjiP6ExaQrnSpIhkurEi.png", originCountry: "US")],
    numberOfEpisodes: 71,
    numberOfSeasons: 6,
    originCountry: ["CA", "US"],
    originalLanguage: "en",
    originalName: "The L Word",
    overview: "A group of lesbian friends struggle with romance and careers in Los Angeles.",
    popularity: 45.582,
    posterPath: "/cRuye5mp69wfnsbfgJiBFQJQo1e.jpg",
    productionCompanies: [ProductionCompany(id: 81151, logoPath: null, name: "Coast Mountain Films Studios", originCountry: "")],
    productionCountries: [ProductionCountry(iso31661: "US", name: "United States of America")],
    seasons: [Season(id: 10609, name: "Specials", overview: "", airDate: null, episodeCount: 4, posterPath: null, seasonNumber: 0)],
    spokenLanguages: [SpokenLanguage(englishName: "English", iso6391: "en", name: "English")],
    status: "Canceled",
    tagline: "",
    type: "Scripted",
    voteAverage: 7.7,
    voteCount: 598);

final testWatchlistTV = TV.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'title',
};
