import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_event.dart';
import 'package:move_app_1/domain/blocs/movie_list_bloc/movie_list_state.dart';
import 'package:move_app_1/domain/model_movie/movie.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class PopularMovieListWidget extends StatelessWidget {
  const PopularMovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider(
      create: (_) => MovieListBloc(const MovieListState.inital())
        ..add(MovieListEventLoadReset())
        ..add(MovieListEventLoadNextPage(locale.languageCode)),
      child: const _MovieListWidget(),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        return SizedBox(
          height: 300, 
          child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10, top: 10),
            itemCount: state.movies.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.movies.length - 1) {
                final locale = Localizations.localeOf(context).languageCode;
                context.read<MovieListBloc>().add(MovieListEventLoadNextPage(locale));
              }
              final movie = state.movies[index];
              return SizedBox(
                width: 150, 
                child: _MovieListRowWidget(movie: movie),
              );
            },
          ),
        );
      },
    );
  }
}

class _MovieListRowWidget extends StatelessWidget {
  final Movie movie;

  const _MovieListRowWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () => _onMovieTap(context, movie.id),
        child: Container(
          width: 200, 
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(

                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: posterPath != null
                      ? ImageDownloader.cachedNetworkImage(posterPath, fit: BoxFit.cover, width: 160, height: 240) 
                      : const SizedBox(), 
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  void _onMovieTap(BuildContext context, int movieId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: movieId,
    );
  }
}
