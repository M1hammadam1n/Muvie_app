import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object?> get props => [];
}

class MovieListEventLoadNextPage extends MovieListEvent {
  final String locale;

  const MovieListEventLoadNextPage(this.locale);

  @override
  List<Object?> get props => [locale];
}

class MovieListEventLoadReset extends MovieListEvent {}

