import 'package:diary_mate/common/widgets/bottom_app_bar/bloc/navigation_bloc.dart';
import 'package:diary_mate/common/widgets/bottom_app_bar/widgets/my_bottom_app_bar.dart';
import 'package:diary_mate/features/diary/presentation/screens/diary_screen.dart';
import 'package:diary_mate/features/movie_recomendation/presentation/screens/movie_recomendation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> pages = [
    const DiaryScreen(),
    const MovieRecomendationScreen(),
  ];

  BottomNavigationBarItem _createBottomNavItem({
    required IconData inactiveIcon,
    required IconData activeIcon,
    required bool isActive,
    required String label,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(inactiveIcon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationChanged) {
              return pages[state.index];
            }
            return pages[0];
          },
        ),
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            int currentIndex = 0;
            if (state is NavigationChanged) {
              currentIndex = state.index;
            }

            final List<BottomNavigationBarItem> bottomNavItems = [
              _createBottomNavItem(
                inactiveIcon: Icons.book_outlined,
                activeIcon: Icons.book,
                isActive: currentIndex == 0,
                context: context,
                label: 'Diary',
              ),
              _createBottomNavItem(
                inactiveIcon: Icons.subtitles_outlined,
                activeIcon: Icons.subtitles,
                isActive: currentIndex == 1,
                context: context,
                label: 'Movie',
              ),
            ];

            return MyBottomAppBar(
              items: bottomNavItems,
              currentIndex: currentIndex,
            );
          },
        ),
      ),
    );
  }
}
