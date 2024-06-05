import 'package:get/get.dart';
import 'package:movie_zone/presentation/pages/home/home.dart';
import 'package:movie_zone/presentation/pages/profile/profile.dart';
import 'package:movie_zone/presentation/pages/video/video.dart';

class CommonController extends GetxController {
  //!initialization
  var selectedPage = 0.obs;
  var pages = [const HomePage(), const VideoPage(), const ProfilePage()];

  //!methods

  void changeNavIndex(int index) {
    selectedPage.value = index;
  }
}
