import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_recommendations_bloc/tv_show_recommendations_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_recommendations_bloc/tv_show_recommendations_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_recommendations_bloc/tv_show_recommendations_state.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class RecommendedTvShow extends StatelessWidget {
  const RecommendedTvShow({Key? key, required this.tvshowId}) : super(key: key);
  final int tvshowId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TvShowRecommendationsBloc>(
      create: (context) => TvShowRecommendationsBloc(
          apiClient: TvShowApiClient())
        ..add(FetchRecommendationsTvShow(tvshowId: tvshowId, locale: 'ru-Ru')),
      child: const SizedBox(
        height: 250,
        child: Scrollbar(
          child: RecommendedTvShowWidget(),
        ),
      ),
    );
  }
}

class RecommendedTvShowWidget extends StatelessWidget {
  const RecommendedTvShowWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowRecommendationsBloc, TvShowRecommendationsState>(
      builder: (context, state) {
        if (state is TvShowRecommendationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TvShowRecommendationsLoaded) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 120,
            itemCount: state.tvshow.length,
            itemBuilder: (context, index) {
              final tvshow = state.tvshow[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _onTvShowTap(context, tvshow.id),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              Container(
                                child: ImageDownloader.cachedNetworkImage(
                                  tvshow.posterPath.toString(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tvshow.name.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    Text(
                                      tvshow.overview.toString(),
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onTvShowTap(BuildContext context, int? tvshowId) {
    if (tvshowId != null) {
      Navigator.of(context).pushNamed(
        MainNavigationRouteNames.tvShowDetails,
        arguments: tvshowId,
      );
    }
  }
}
