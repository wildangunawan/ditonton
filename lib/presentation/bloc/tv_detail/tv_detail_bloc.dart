import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTVDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(Empty()) {
    on<LoadTvDetail>((event, emit) async {
      final id = event.id;
      
      emit(Loading());
      final result = await _getTvDetail.execute(id);

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
