import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_test.mocks.dart';

@GenerateMocks([GetPopularTVs])
void main() {
  late MockGetPopularTVs mock;
  late PopularTvBloc bloc;

  setUp(() {
    mock = MockGetPopularTVs();
    bloc = PopularTvBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testTVList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadPopularTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );
}
