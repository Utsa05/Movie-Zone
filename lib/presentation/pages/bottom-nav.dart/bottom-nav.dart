import 'package:flutter/material.dart';
import 'package:movie_zone/constants/theme.dart';
import 'package:get/get.dart';
import 'package:movie_zone/controllers/common-controller.dart';

class BottomNavPage extends GetView<CommonController> {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.pages[controller.selectedPage.value];
      }),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: const Color.fromARGB(255, 1, 1, 1),
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          onTap: controller.changeNavIndex,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/icons/home.png',
                height: 25.0,
                width: 25.0,
              ),
            ),
            BottomNavigationBarItem(
                label: '',
                icon: Image.asset(
                  'assets/icons/video.png',
                  height: 25.0,
                  width: 25.0,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Image.asset(
                  'assets/icons/user.png',
                  height: 25.0,
                  width: 25.0,
                  color: AppTheme.grey,
                )),
          ]),
    );
  }
}
