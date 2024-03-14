// ignore_for_file: camel_case_types, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_state.dart';
import 'package:move_app_1/app_images/app_images.dart';
import 'package:move_app_1/ui/widgets/radial_percent/radial_percent_widget.dart';
import 'package:move_app_1/ui/widgets/movie_list/movie_list_widget.dart';

class TvShowDetailsMainInfoWidget extends StatelessWidget {
  const TvShowDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoading) {
        } else if (state is TvShowDetailsLoaded) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopPosterWidget(),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: _TvShowNameWidget(),
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
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Страна Происхождения',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Genres(),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Жанры',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: GenresTho(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      'Количество Сезонов - ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    numberOfSeasons(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Row(
                  children: [
                    Text(
                      'Cоличество Серий - ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    NumberOfEpisodes(),
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
                height: 250,
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

class NumberOfEpisodes extends StatelessWidget {
  const NumberOfEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Text(
          tvshowDetails.numberOfEpisodes.toString(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class numberOfSeasons extends StatelessWidget {
  const numberOfSeasons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Text(
          tvshowDetails.numberOfSeasons.toString(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class _ReliesDateMovie extends StatelessWidget {
  const _ReliesDateMovie();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Text(
          formatDate(tvshowDetails.firstAirDate),
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 17,
          ),
        );
      }
      return const SizedBox();
    });
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Text(
          tvshowDetails.overview.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        );
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
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
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
          child:
              ImageDownloader.cachedNetworkImage(tvshowDetails.backdropPath!),
        );
      } else if (state is TvShowDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const SizedBox();
    });
  }
}

class _TvShowNameWidget extends StatelessWidget {
  const _TvShowNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tvshowDetails.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoading) {
        } else if (state is TvShowDetailsLoaded) {
          final tvshowDetails = state.tvshowDetails;
          return Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: RadialPercentWidget(
                    percent: tvshowDetails.voteAverage / 10,
                    fillColor: const Color.fromARGB(255, 14, 33, 36),
                    lineColor: const Color(0XFF09faca),
                    freeColor: const Color(0XFF47243e),
                    lineWidth: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tvshowDetails.voteAverage.toString(),
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
              const Text(
                'Рейтинг',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
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

class Genres extends StatelessWidget {
  const Genres({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoading) {
        } else if (state is TvShowDetailsLoaded) {
          final productionCountries = state.tvshowDetails.productionCountries
              .map((productionCountries) => productionCountries.name)
              .join(', ');
          return Text(
            productionCountries.toString(),
            style: const TextStyle(
              color: Colors.white54,
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
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final genreNames =
            state.tvshowDetails.genres.map((genre) => genre.name).join(', ');
        return Text(
          genreNames.toString(),
          style: const TextStyle(
            color: Colors.white54,
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
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoading) {
        } else if (state is TvShowDetailsLoaded &&
            state.actorsData.isNotEmpty) {
          final actors = state.actorsData;
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
                                height: MediaQuery.of(context).size.height *
                                    0.184,
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

