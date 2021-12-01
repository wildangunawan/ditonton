import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_test.mocks.dart';

@GenerateMocks([GetTVDetail])
void main() {
  late TvDetailBloc bloc;
  late MockGetTVDetail mock;

  setUp(() {
    mock = MockGetTVDetail();
    bloc = TvDetailBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute(1))
          .thenAnswer((_) async => Right(testTVDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTvDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testTVDetail),
    ],
    verify: (bloc) {
      verify(mock.execute(1));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when data is failed to load',
    build: () {
      when(mock.execute(1))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadTvDetail(1)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error('Server Failure'),
    ],
    verify: (bloc) {
      verify(mock.execute(1));
    },
  );
}
