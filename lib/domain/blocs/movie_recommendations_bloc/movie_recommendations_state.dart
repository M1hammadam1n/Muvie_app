import 'package:equatable/equatable.dart';
import 'package:move_app_1/domain/model_movie/movie_recommended.dart';


abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationsInitial extends MovieRecommendationsState {}

class MovieRecommendationsLoading extends MovieRecommendationsState {}

class MovieRecommendationsLoaded extends MovieRecommendationsState {
  final List<MovieRecommendations> movies;

  const MovieRecommendationsLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieRecommendationsError extends MovieRecommendationsState {}
