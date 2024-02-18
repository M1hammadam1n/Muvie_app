import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_state.dart';
import 'package:move_app_1/app_images/app_images.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class TvShowListWidget extends StatelessWidget {
  const TvShowListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return BlocProvider(
      create: (_) => TvShowListBloc(const TvShowListState.inital())
        ..add(TvShowListEventLoadReset())
        ..add(TvShowListEventLoadNextPage(locale.languageCode)),
      child: const _TvShowListWidget(),
    );
  }
}

class _TvShowListWidget extends StatelessWidget {
  const _TvShowListWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowListBloc, TvShowListState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          itemCount: state.tvshow.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            if (index >= state.tvshow.length - 1) {
              final locale = Localizations.localeOf(context).languageCode;
              context
                  .read<TvShowListBloc>()
                  .add(TvShowListEventLoadNextPage(locale));
            }
            final tvshow = state.tvshow[index];
            return _TvShowListRowWidget(tvshow: tvshow);
          },
        );
      },
    );
  }
}

class _TvShowListRowWidget extends StatelessWidget {
  final TvShow tvshow;
  const _TvShowListRowWidget({Key? key, required this.tvshow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath = tvshow.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: Colors.black.withOpacity(0.15),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                posterPath != null
                    ? ImageDownloader.cachedNetworkImage(posterPath)
                    : Image.asset(
                        AppImages.errorImage,
                      ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        tvshow.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        formatDate(tvshow.firstAirDate),
                        style: const TextStyle(color: Colors.white30),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tvshow.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _onTvShowTap(context, tvshow.id),
            ),
          ),
        ],
      ),
    );
  }

  void _onTvShowTap(BuildContext context, int tvshowId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tvShowDetails,
      arguments: tvshowId,
    );
  }
}

String formatDate(DateTime? date) {
  if (date != null) {
    final dateFormat = DateFormat.yMMMMd();
    return dateFormat.format(date);
  }
  return '';
}
