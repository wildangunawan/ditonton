import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.airDate,
    required this.episodeCount,
    required this.posterPath,
    required this.seasonNumber,
  });

  final int id;
  final String name;
  final String overview;
  final DateTime airDate;
  final int episodeCount;
  final String posterPath;
  final int seasonNumber;

  @override
  List<Object> get props => [id, name, overview, airDate, episodeCount, posterPath, seasonNumber];
}
