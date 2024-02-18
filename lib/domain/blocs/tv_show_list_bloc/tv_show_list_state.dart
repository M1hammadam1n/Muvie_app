import 'package:move_app_1/domain/model_tvshow/tv_show.dart';

class TvShowListContainer {
  final List<TvShow> tvshow;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const TvShowListContainer.inital()
      : tvshow = const <TvShow>[],
        currentPage = 0,
        totalPage = 1;

  TvShowListContainer({
    required this.tvshow,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvShowListContainer &&
          runtimeType == other.runtimeType &&
          tvshow == other.tvshow &&
          currentPage == other.currentPage &&
          totalPage == other.totalPage;

  @override
  int get hashCode =>
      tvshow.hashCode ^ currentPage.hashCode ^ totalPage.hashCode;

 TvShowListContainer copyWith({
    List<TvShow>? tvshow,
    int? currentPage,
    int? totalPage,
  }) {
    return TvShowListContainer(
      tvshow: tvshow ?? this.tvshow,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}

class TvShowListState {
  final TvShowListContainer popularTvShowContainer;

  List<TvShow> get tvshow =>
      popularTvShowContainer.tvshow;

  const TvShowListState.inital()
      : popularTvShowContainer = const TvShowListContainer.inital();

  TvShowListState({
    required this.popularTvShowContainer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvShowListState &&
          runtimeType == other.runtimeType &&
          popularTvShowContainer == other.popularTvShowContainer;

  @override
  int get hashCode =>
      popularTvShowContainer.hashCode;

 TvShowListState copyWith({
   TvShowListContainer? popularTvShowContainer,
  }) {
    return TvShowListState(
      popularTvShowContainer:
          popularTvShowContainer ?? this.popularTvShowContainer,
    );
  }
}
