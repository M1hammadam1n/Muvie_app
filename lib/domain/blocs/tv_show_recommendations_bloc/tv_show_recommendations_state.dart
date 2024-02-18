import 'package:equatable/equatable.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_recommendations.dart';



abstract class TvShowRecommendationsState extends Equatable {
  const TvShowRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvShowRecommendationsInitial extends TvShowRecommendationsState {}

class TvShowRecommendationsLoading extends TvShowRecommendationsState {}

class TvShowRecommendationsLoaded extends TvShowRecommendationsState {
  final List<TvShowRecommendations> tvshow;

  const TvShowRecommendationsLoaded({required this.tvshow});

  @override
  List<Object> get props => [tvshow];
}

class TvShowRecommendationsError extends TvShowRecommendationsState {}
