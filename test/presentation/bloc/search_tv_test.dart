import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/bloc/search_tv/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_test.mocks.dart';

@GenerateMocks([SearchTVs])
void main() {
  late MockSearchTVs mock;
  late SearchTvBloc bloc;

  setUp(() {
    mock = MockSearchTVs();
    bloc = SearchTvBloc(mock);
  });

  test('initial state is correct', () {
    expect(bloc.state, Empty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is loaded successfully',
    build: () {
      when(mock.execute("the l word"))
          .thenAnswer((_) async => Right(testTVList));
      return bloc;
    },
    act: (bloc) => bloc.add(OnChange("the l word")),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      HasData(testTVList),
    ],
    verify: (bloc) {
      verify(mock.execute("the l word"));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when data failed to be loaded',
    build: () {
      when(mock.execute("the l word"))
          .thenAnswer((_) async => Left(ServerFailure("Server Failure")));
      return bloc;
    },
    act: (bloc) => bloc.add(OnChange("the l word")),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      Loading(),
      Error("Server Failure"),
    ],
    verify: (bloc) {
      verify(mock.execute("the l word"));
    },
  );
}
