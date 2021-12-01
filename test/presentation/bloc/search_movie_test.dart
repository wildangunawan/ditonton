import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MockSearchMovies mock;
  late SearchMovieBloc bloc;

  setUp(() {
    mock = MockSearchMovies();
    bloc = SearchMovieBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute("spiderman"))
          .thenAnswer((_) async => Right(testMovieList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnChange("spiderman")),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mock.execute("spiderman"));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'Should emit [Loading, Error] when data failed to be loaded',
    build: () {
      when(mock.execute("spiderman"))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(OnChange("spiderman")),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error("Server Failure"),
    ],
    verify: (bloc) {
      verify(mock.execute("spiderman"));
    },
  );
}
