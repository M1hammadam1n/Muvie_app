import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/movie_api_client.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_event.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_state.dart';
import 'package:move_app_1/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:move_app_1/ui/widgets/movie_recommendations/movie_recommendations_widget.dart';

class MovieDetailsWidget extends StatelessWidget {
  final int movieId;
  const MovieDetailsWidget({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsBloc(apiClient: MovieApiClient())
        ..add(FetchMovieDetails(movieId: movieId, locale: 'ru-Ru')),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF2F2C44),
          title: const _TitleWidget(),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ColoredBox(
          color: const Color.fromRGBO(28, 26, 41, 1.0),
          child: _BodyWidget(movieId: movieId),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsLoading) {
      } else if (state is MovieDetailsLoaded) {
        final movieDetails = state.movieDetails;
        return Text(
          movieDetails.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      } else if (state is MovieDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const Text('Загрузка данных...',
          style: TextStyle(color: Colors.white));
    });
  }
}

class _BodyWidget extends StatelessWidget {
  final int movieId;
  const _BodyWidget({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailsLoaded) {
          return ListView(
            children: [
              const MovieDetailsMainInfoWidget(),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Похожие Фильмы',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 290,
                child: Scrollbar(
                  child: RecommendedMovie(
                    movieId: movieId,
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
