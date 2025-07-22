import 'package:eco_step/core/util/style/colors.dart';
import 'package:eco_step/core/widgets/common/my_bottom_navigation_bar.dart';
import 'package:eco_step/features/counter/presentation/views/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      const CounterView(),
    ];
  }

  @override
  Widget build(BuildContext context) {   
    ThemeColors colors = ThemeColors.of(context); 

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.gray50,
        toolbarHeight: 18,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: colors.gray50,
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