import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTVs _getPopularTVs;

  PopularTvBloc(this._getPopularTVs) : super(Empty()) {
    on<LoadPopularTV>((event, emit) async {
      emit(Loading());
      final result = await _getPopularTVs.execute();

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
