import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    firstAirDate: DateTime.parse("2021-10-12"),
    genreIds: [10765,
		  35,
		  80],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 6477.14,
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
    voteAverage: 8,
    voteCount: 2312
  );
  final tTVResponseModel =
      TVResponse(tvList: <TVModel>[tTVModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air_tv.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [
              10765,
              35,
              80
            ],
            "id": 90462,
            "name": "Chucky",
            "origin_country": [
              "US"
            ],
            "original_language": "en",
            "original_name": "Chucky",
            "overview": "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
            "popularity": 6477.14,
            "poster_path": "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
            "vote_average": 8,
            "vote_count": 2312
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
