import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_app_1/domain/factoryes/scren_factoryes.dart';
import 'package:move_app_1/ui/widgets/main_screen/main_screen_widget_cubit.dart'; 

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainScreenCubit(),
      child: BlocBuilder<MainScreenCubit, int>(
        builder: (context, selectedTab) {
          return Scaffold(
            backgroundColor:const Color(0XFF1c1a29),
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 40, 38, 61),
              centerTitle: true,
              title: const Text(
                'MOVIE APP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: IndexedStack(
              index: selectedTab,
              children: [
                ScreenFactory().makeMovieList(),
                ScreenFactory().makeTvShowList(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedTab,
              backgroundColor: const Color(0XFF2F2C44),
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.white30,
                  icon: Icon(Icons.movie_creation_outlined),
                  label: 'Фильмы',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white30,
                  icon: Icon(Icons.tv),
                  label: 'Сериалы',
                ),
              ],
              onTap: (index) =>
                  context.read<MainScreenCubit>().selectTab(index),
            ),
          );
        },
      ),
    );
  }
}
