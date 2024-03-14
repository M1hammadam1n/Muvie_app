import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/auth_bloc/auth_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_state.dart';
import 'package:move_app_1/domain/blocs/news_movie_bloc/news_movie_bloc.dart';
import 'package:move_app_1/domain/blocs/news_movie_bloc/news_movie_event.dart';
import 'package:move_app_1/domain/blocs/news_movie_bloc/news_movie_state.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_state.dart';
import 'package:move_app_1/ui/widgets/auth/auth_cubit.dart';
import 'package:move_app_1/ui/widgets/auth/auth_widget.dart';
import 'package:move_app_1/ui/widgets/loader_widget/loader_view_cubit.dart';
import 'package:move_app_1/ui/widgets/loader_widget/loader_widget.dart';
import 'package:move_app_1/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:move_app_1/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:move_app_1/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:move_app_1/ui/widgets/news/movie_popular_widget.dart';
import 'package:move_app_1/ui/widgets/news/movie_top_rated.dart';
import 'package:move_app_1/ui/widgets/tv_show_details/tv_show_details_widget.dart';
import 'package:move_app_1/ui/widgets/tv_show_list/tv_show_list_widget.dart';

class ScreenFactory {
  AuthBloc? _authBloc;
  MovieDetailsBloc? _movieDetailsBloc;
  TvShowDetailsBloc? _tvshowDetailsBloc;
   final MovieApiClient _movieApiClient = MovieApiClient();

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (_) => LoaderViewCubit(
        LoaderViewCubitState.unknown,
        authBloc,
      ),
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;

    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(
        AuthViewCubitSuccessFormFillInProgressState(),
        authBloc,
      ),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    _authBloc?.close();
    _authBloc = null;
    return  const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    final movieDetailsBloc =
    _movieDetailsBloc ?? MovieDetailsBloc(apiClient: MovieApiClient());
    _movieDetailsBloc = movieDetailsBloc;
    return BlocProvider<MovieDetailsBloc>(
      create: (_) => movieDetailsBloc,
      child: MovieDetailsWidget(movieId: movieId),
    );
  }

  Widget makeTvShowDetails(int tvshowId) {
    final tvshowDetailsBloc = 
    _tvshowDetailsBloc ?? TvShowDetailsBloc(tvShowApiClient: TvShowApiClient());
    _tvshowDetailsBloc = tvshowDetailsBloc;
    return BlocProvider<TvShowDetailsBloc>(
      create: (_) => tvshowDetailsBloc,
      child: TvShowDetailsWidget(tvshowId: tvshowId),
    );
  }

  Widget makeMovieList() {
    return BlocProvider(
      create: (_) => MovieListBloc(
        const MovieListState.inital(),
      ),
      child: const MovieListWidget(),
    );
  }

    Widget makeTopMovieList() {
    return BlocProvider(
      create: (_) => TopMovieListBloc(
        const TopMovieListState.inital(),
      ),
      child: const MovieTopRated(),
    );
  }

  Widget makeTvShowList() {
    return BlocProvider(
      create: (_) => TvShowListBloc(
        const TvShowListState.inital(),
      ),
      child: const TvShowListWidget(),
    );
  }
}
