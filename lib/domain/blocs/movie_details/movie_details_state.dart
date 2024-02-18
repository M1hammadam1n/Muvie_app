import 'package:equatable/equatable.dart';
import 'package:move_app_1/domain/model_movie/movie_details.dart';
import 'package:move_app_1/domain/model_movie/movie_details_credits.dart';
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetails movieDetails;
  final List<Actor> actorData;

  const MovieDetailsLoaded({required this.movieDetails, required this.actorData});

  @override
  List<Object> get props => [movieDetails, actorData];
}

class MovieDetailsError extends MovieDetailsState {}
