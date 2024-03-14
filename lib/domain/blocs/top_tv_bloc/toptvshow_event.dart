import 'package:equatable/equatable.dart';

abstract class TopTvShowListEvent extends Equatable {
  const TopTvShowListEvent();

  @override
  List<Object?> get props => [];
}

class TopTvShowListEventLoadNextPage extends TopTvShowListEvent {
  final String locale;

  const TopTvShowListEventLoadNextPage(this.locale);

  @override
  List<Object?> get props => [locale];
}

class TopTvShowListEventLoadReset extends TopTvShowListEvent {}

