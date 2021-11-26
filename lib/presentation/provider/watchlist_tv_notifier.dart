import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:flutter/foundation.dart';

class WatchlistTVNotifier extends ChangeNotifier {
  var _watchlistTVs = <TV>[];
  List<TV> get watchlistTVs => _watchlistTVs;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVNotifier({required this.getWatchlistTVs});

  final GetWatchlistTVs getWatchlistTVs;

  Future<void> fetchWatchlistTVs() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVs.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTVs = tvsData;
        notifyListeners();
      },
    );
  }
}
