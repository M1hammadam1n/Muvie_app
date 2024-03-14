import 'package:flutter/material.dart';
import 'package:move_app_1/ui/widgets/news/movie_popular_widget.dart';
import 'package:move_app_1/ui/widgets/news/movie_top_rated.dart';
import 'package:move_app_1/ui/widgets/news/tvshow_popular_widget.dart';
import 'package:move_app_1/ui/widgets/news/tvshow_top_rated.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
                physics: const BouncingScrollPhysics(),
      children:const  [
         Column(
           children: [
            Text('Популярные Фильмы',style: TextStyle(fontSize: 30,color: Colors.white),),
             PopularMovieListWidget(),
           ],
         ),
         Column(
           children: [
            Text('Топ Фильмы',style: TextStyle(fontSize: 30,color: Colors.white),),
             MovieTopRated(),
           ],
         ),
         
             Column(
           children: [
            Text('Топ Сериалы',style: TextStyle(fontSize: 30,color: Colors.white),),
             TvShowTopRated(),
           ],
         ),
         Column(
           children: [
            Text('Популярные Сериалы',style: TextStyle(fontSize: 30,color: Colors.white),),
              TvShowPopular(),
           ],
         ),
      ],
    );
  }
}
