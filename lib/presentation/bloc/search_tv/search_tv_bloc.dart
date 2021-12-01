import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTVs _searchTVs;

  SearchTvBloc(this._searchTVs) : super(Empty()) {
    on<OnChange>((event, emit) async {
      final query = event.query;

      emit(Loading());
      final result = await _searchTVs.execute(query);

      result.fold((l) => emit(Error(l.message)), (r) => emit(HasData(r)));
    });
  }
}
