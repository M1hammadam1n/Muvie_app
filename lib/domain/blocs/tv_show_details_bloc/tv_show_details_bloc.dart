import 'package:bloc/bloc.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_state.dart';

class TvShowDetailsBloc extends Bloc<TvShowDetailsEvent, TvShowDetailsState> {
  final TvShowApiClient tvShowApiClient;

  TvShowDetailsBloc({required this.tvShowApiClient})
      : super(TvShowDetailsInitial()) {
    on<FetchTvShowDetails>(_onFetchTvShowDetails);
  }

  Future<void> _onFetchTvShowDetails(
    FetchTvShowDetails event,
    Emitter<TvShowDetailsState> emit,
  ) async {
    emit(TvShowDetailsLoading());
    try {
      final tvshowDetails =
          await tvShowApiClient.tvShowDetails(event.tvshowId, event.locale);
      final actorData = await tvShowApiClient.tvShowDetailsCredits(
          event.tvshowId, event.locale);
      emit(TvShowDetailsLoaded(
          tvshowDetails: tvshowDetails, actorsData: actorData ?? []));
    } catch (e) {
      emit(
        TvShowDetailsError(),
      );
    }
  }
}
