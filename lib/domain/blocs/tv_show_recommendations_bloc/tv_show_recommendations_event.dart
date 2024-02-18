import 'package:equatable/equatable.dart';

abstract class TvShowRecommendationsEvent extends Equatable {
  const TvShowRecommendationsEvent();

  @override
  List<Object> get props => [];
}
class FetchRecommendationsTvShow extends TvShowRecommendationsEvent {
  final int tvshowId;
  final String? locale; // Make the locale parameter nullable

  const FetchRecommendationsTvShow({required this.tvshowId, this.locale});
}
