abstract class TvShowDetailsEvent {
  const TvShowDetailsEvent();
}

class FetchTvShowDetails extends TvShowDetailsEvent {
  final int tvshowId;
  final String locale;

  const FetchTvShowDetails({required this.tvshowId, required this.locale});
}
