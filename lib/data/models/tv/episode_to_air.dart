import 'package:equatable/equatable.dart';

class EpisodeToAirModel extends Equatable {
    EpisodeToAirModel({
        required this.airDate,
        required this.episodeNumber,
        required this.id,
        required this.name,
        required this.overview,
        required this.productionCode,
        required this.seasonNumber,
        required this.stillPath,
        required this.voteAverage,
        required this.voteCount,
    });

    DateTime airDate;
    int episodeNumber;
    int id;
    String name;
    String overview;
    String productionCode;
    int seasonNumber;
    dynamic stillPath;
    int voteAverage;
    int voteCount;

    factory EpisodeToAirModel.fromJson(Map<String, dynamic> json) => EpisodeToAirModel(
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "air_date": "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };

    @override
    List<Object> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
    ];
}