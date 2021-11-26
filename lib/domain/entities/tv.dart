import 'package:equatable/equatable.dart';

class TV extends Equatable {
  TV({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  TV.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.originalName,
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
