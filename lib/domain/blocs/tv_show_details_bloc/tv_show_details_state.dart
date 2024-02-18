import 'package:equatable/equatable.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_details.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show_details_credits.dart';

sealed class TvShowDetailsState extends Equatable {
  const TvShowDetailsState();

  @override
  List<Object> get props => [];
}

final class TvShowDetailsInitial extends TvShowDetailsState {}

final class TvShowDetailsLoading extends TvShowDetailsState {}

final class TvShowDetailsLoaded extends TvShowDetailsState {
  final TvShowDetails tvshowDetails;
  final List<Actors> actorsData;
  const TvShowDetailsLoaded(
      {required this.tvshowDetails, required this.actorsData});
        @override
  List<Object> get props => [tvshowDetails, actorsData];
}

class  TvShowDetailsError extends TvShowDetailsState{}