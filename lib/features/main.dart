import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/widgets/common/my_bottom_navigation_bar.dart';
import 'package:eco_step/features/home/presentation/views/home_view.dart';
import 'package:eco_step/features/map/presentation/views/map_view.dart';
import 'package:eco_step/features/history/presentation/views/history_view.dart';
import 'package:eco_step/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    
    pages = [
      const HomeView(),
      const MapView(),
      const HistoryView(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      extendBody: true,
      body: pages[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}