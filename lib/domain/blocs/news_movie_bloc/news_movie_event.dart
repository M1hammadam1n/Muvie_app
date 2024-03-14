import 'package:equatable/equatable.dart';

abstract class TopMovieListEvent extends Equatable {
  const TopMovieListEvent();

  @override
  List<Object?> get props => [];
}

class TopMovieListEventLoadNextPage extends TopMovieListEvent {
  final String locale;

  const TopMovieListEventLoadNextPage(this.locale);

  @override
  List<Object?> get props => [locale];
}

class TopMovieListEventLoadReset extends TopMovieListEvent {}

