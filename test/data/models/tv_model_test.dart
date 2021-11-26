import 'package:ditonton/data/models/tv_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final tTVModel = TVModel(
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
    voteCount: 598
  );

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, testTV);
  });
}
