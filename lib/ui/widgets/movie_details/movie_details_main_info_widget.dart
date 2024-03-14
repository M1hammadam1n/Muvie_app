import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_bloc.dart';
import 'package:move_app_1/domain/blocs/movie_details/movie_details_state.dart';
import 'package:move_app_1/app_images/app_images.dart';
import 'package:move_app_1/ui/widgets/radial_percent/radial_percent_widget.dart';
import 'package:move_app_1/ui/widgets/movie_list/movie_list_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
        } else if (state is MovieDetailsLoaded) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopPosterWidget(),
              Padding(
                padding: EdgeInsets.all(10),
                child: _MovieNameWidget(),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'дата выхода',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: _ReliesDateMovie(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    Icon(Icons.schedule, color: Colors.white),
                    SizedBox(width: 7),
                    TimeWidget(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined, color: Colors.white),
                    SizedBox(width: 7),
                    Genres(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: Row(
                  children: [
                    Icon(Icons.movie_outlined, color: Colors.white),
                    SizedBox(width: 7),
                    GenresTho(),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _ScoreWidget(),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(10),
                child: _OverviwWidget(),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: _DescriptionWidget(),
              ),
              SizedBox(height: 20),
              Text(
                'Актерский состав',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 270,
                child: Scrollbar(
                  child: ActorsWidget(),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ReliesDateMovie extends StatelessWidget {
  const _ReliesDateMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsLoading) {
      } else if (state is MovieDetailsLoaded) {
        final movieDetails = state.movieDetails;
        return Text(
          formatDate(movieDetails.releaseDate),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        );
      } else if (state is MovieDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const SizedBox();
    });
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsLoading) {
      } else if (state is MovieDetailsLoaded) {
        final movieDetails = state.movieDetails;
        return Text(
          movieDetails.overview.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        );
      } else if (state is MovieDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const SizedBox();
    });
  }
}

class _OverviwWidget extends StatelessWidget {
  const _OverviwWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Обзор',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsLoading) {
      } else if (state is MovieDetailsLoaded) {
        final movieDetails = state.movieDetails;
        return Container(
           decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0XFF09faca),
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 100.0,
              ),
            ],
          ),
          width: double.infinity,
          child: ImageDownloader.cachedNetworkImage(movieDetails.backdropPath!),
        );
      } else if (state is MovieDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const SizedBox();
    });
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

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
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
        } else if (state is MovieDetailsLoaded) {
          final movieDetails = state.movieDetails;
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: RadialPercentWidget(
                    percent: movieDetails.voteAverage / 10,
                    fillColor: const Color.fromARGB(255, 14, 33, 36),
                    lineColor: const Color(0XFF09faca),
                    freeColor: const Color(0XFF47243e),
                    lineWidth: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movieDetails.voteAverage.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        const Text(
                          ' /10',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Рейтинг',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  )),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
        } else if (state is MovieDetailsLoaded) {
          final movieDetails = state.movieDetails;
          final runtime = movieDetails.runtime ?? 0;
          final duration = Duration(minutes: runtime);
          final hours = duration.inHours;
          final minutes = duration.inMinutes.remainder(60);
          final timeString = '${hours}h ${minutes}m';
          return Text(
            timeString.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class Genres extends StatelessWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
        } else if (state is MovieDetailsLoaded) {
          final productionCountries = state.movieDetails.productionCountries
              .map((productionCountries) => productionCountries.name)
              .join(', ');
          return Text(
            productionCountries.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class GenresTho extends StatelessWidget {
  const GenresTho({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
      if (state is MovieDetailsLoading) {
      } else if (state is MovieDetailsLoaded) {
        final genreNames =
            state.movieDetails.genres.map((genre) => genre.name).join(', ');
        return Text(
          genreNames.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class ActorsWidget extends StatelessWidget {
  const ActorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state is MovieDetailsLoading) {
        } else if (state is MovieDetailsLoaded && state.actorData.isNotEmpty) {
          final actors = state.actorData;
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemExtent: 120,
              itemCount: actors.length,
              itemBuilder: (context, index) {
                final actor = actors[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      children: [
                        actor.profilePath != null
                            ? SizedBox(
                                child: ImageDownloader.cachedNetworkImage(
                                  actor.profilePath.toString(),
                                ),
                              )
                            : Image.asset(
                                AppImages.errorImage,
                                height:
                                    MediaQuery.of(context).size.height * 0.184,
                                fit: BoxFit.cover,
                              ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  actor.character,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  actor.originalName,
                                  style: const TextStyle(
                                    color: Colors.white54,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}
