// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/bloc/tv_detail_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_detail.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTVRepository extends _i1.Fake implements _i2.TVRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTVDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTVDetail extends _i1.Mock implements _i4.GetTVDetail {
  MockGetTVDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TVRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVRepository()) as _i2.TVRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<_i3.Either<_i6.Failure, _i7.TVDetail>>.value(
                  _FakeEither<_i6.Failure, _i7.TVDetail>()))
          as _i5.Future<_i3.Either<_i6.Failure, _i7.TVDetail>>);
}
