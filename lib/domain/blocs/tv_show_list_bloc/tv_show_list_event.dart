import 'package:equatable/equatable.dart';

abstract class TvShowListEvent extends Equatable {
  const TvShowListEvent();

  @override
  List<Object?> get props => [];
}

class TvShowListEventLoadNextPage extends TvShowListEvent {
  final String locale;

  const TvShowListEventLoadNextPage(this.locale);

  @override
  List<Object?> get props => [locale];
}

class TvShowListEventLoadReset extends TvShowListEvent {}

