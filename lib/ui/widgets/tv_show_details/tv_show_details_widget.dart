import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/api_client/tv_show_api_client.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_event.dart';
import 'package:move_app_1/domain/blocs/tv_show_details_bloc/tv_show_details_state.dart';
import 'package:move_app_1/ui/widgets/tv_show_details/tv_show_details_main_info_widget.dart';
import 'package:move_app_1/ui/widgets/tv_show_recommendations/tv_show_recommendations_widget.dart';

class TvShowDetailsWidget extends StatelessWidget {
  final int tvshowId;
  const TvShowDetailsWidget({
    Key? key,
    required this.tvshowId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TvShowDetailsBloc(tvShowApiClient: TvShowApiClient())
        ..add(FetchTvShowDetails(tvshowId: tvshowId, locale: 'ru-Ru')),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:const Color(0XFF2F2C44),
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
          child: _BodyWidget(tvshowId: tvshowId),
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
        builder: (context, state) {
      if (state is TvShowDetailsLoading) {
      } else if (state is TvShowDetailsLoaded) {
        final tvshowDetails = state.tvshowDetails;
        return Text(
          tvshowDetails.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        );
      } else if (state is TvShowDetailsError) {
        return const Center(child: Text('Ошибка загрузки данных'));
      }
      return const Text('Загрузка данных...',
          style: TextStyle(color: Colors.white));
    });
  }
}

class _BodyWidget extends StatelessWidget {
  final int tvshowId;
  const _BodyWidget({required this.tvshowId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      builder: (context, state) {
        if (state is TvShowDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TvShowDetailsLoaded) {
          return ListView(
            children: [
              const TvShowDetailsMainInfoWidget(),
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
                height: 270,
                child: Scrollbar(
                  child: RecommendedTvShow(
                    tvshowId: tvshowId,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
