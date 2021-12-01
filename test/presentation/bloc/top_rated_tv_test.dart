import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_test.mocks.dart';

@GenerateMocks([GetTopRatedTVs])
void main() {
  late MockGetTopRatedTVs mock;
  late TopRatedTvBloc bloc;

  setUp(() {
    mock = MockGetTopRatedTVs();
    bloc = TopRatedTvBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTV()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testTVList),
    ],
    verify: (bloc) {
      verify(mock.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute())
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTopRatedTV()),
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
