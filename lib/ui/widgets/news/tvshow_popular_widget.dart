import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/image_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_list_bloc/tv_show_list_state.dart';
import 'package:move_app_1/domain/model_tvshow/tv_show.dart';
import 'package:move_app_1/ui/navigation/navigation.dart';

class TvShowPopular extends StatelessWidget {
  const TvShowPopular({Key? key}) : super(key: key);

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
  const _TvShowListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowListBloc, TvShowListState>(
      builder: (context, state) {
        return SizedBox(
          height: 300, 
          child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10, top: 10),
            itemCount: state.tvshow.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.tvshow.length - 1) {
                final locale = Localizations.localeOf(context).languageCode;
                context.read<TvShowListBloc>().add(TvShowListEventLoadNextPage(locale));
              }
              final tvshow = state.tvshow[index];
              return SizedBox(
                width: 150, 
                child: _TvShowListRowWidget(tvshow: tvshow),
              );
            },
          ),
        );
      },
    );
  }
}

class _TvShowListRowWidget extends StatelessWidget {
  final TvShow tvshow;

  const _TvShowListRowWidget({Key? key, required this.tvshow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath = tvshow.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: () => _onTvShowTap(context, tvshow.id),
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
                  tvshow.name,
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

  void _onTvShowTap(BuildContext context, int tvshowId) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tvShowDetails,
      arguments: tvshowId,
    );
  }
}
