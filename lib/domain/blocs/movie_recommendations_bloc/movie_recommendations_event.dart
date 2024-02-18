import 'package:equatable/equatable.dart';

abstract class MovieRecommendationsEvent extends Equatable {
  const MovieRecommendationsEvent();

  @override
  List<Object> get props => [];
}
class FetchRecommendationsMovie extends MovieRecommendationsEvent {
  final int movieId;
  final String? locale; 

  const FetchRecommendationsMovie({required this.movieId, this.locale});
}
