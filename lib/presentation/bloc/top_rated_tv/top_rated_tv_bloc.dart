import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTVs _getTopRatedTVs;

  TopRatedTvBloc(this._getTopRatedTVs) : super(Empty()) {
    on<LoadTopRatedTV>((event, emit) async {
      emit(Loading());
      final result = await _getTopRatedTVs.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
