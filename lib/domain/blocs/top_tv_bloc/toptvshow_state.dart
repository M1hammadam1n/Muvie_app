import 'package:move_app_1/domain/model_tvshow/tv_show.dart';

class TopTvShowListContainer {
  final List<TvShow> tvshow;
  final int currentPage;
  final int totalPage;

  bool get isComplete => currentPage >= totalPage;

  const TopTvShowListContainer.inital()
      : tvshow = const <TvShow>[],
        currentPage = 0,
        totalPage = 1;

  TopTvShowListContainer({
    required this.tvshow,
    required this.currentPage,
    required this.totalPage,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopTvShowListContainer &&
          runtimeType == other.runtimeType &&
          tvshow == other.tvshow &&
          currentPage == other.currentPage &&
          totalPage == other.totalPage;

  @override
  int get hashCode =>
      tvshow.hashCode ^ currentPage.hashCode ^ totalPage.hashCode;

 TopTvShowListContainer copyWith({
    List<TvShow>? tvshow,
    int? currentPage,
    int? totalPage,
  }) {
    return TopTvShowListContainer(
      tvshow: tvshow ?? this.tvshow,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}

class TopTvShowListState {
  final TopTvShowListContainer popularTvShowContainer;

  List<TvShow> get tvshow =>
      popularTvShowContainer.tvshow;

  const TopTvShowListState.inital()
      : popularTvShowContainer = const TopTvShowListContainer.inital();

  TopTvShowListState({
    required this.popularTvShowContainer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopTvShowListState &&
          runtimeType == other.runtimeType &&
          popularTvShowContainer == other.popularTvShowContainer;

  @override
  int get hashCode =>
      popularTvShowContainer.hashCode;

 TopTvShowListState copyWith({
   TopTvShowListContainer? popularTvShowContainer,
  }) {
    return TopTvShowListState(
      popularTvShowContainer:
          popularTvShowContainer ?? this.popularTvShowContainer,
    );
  }
}
