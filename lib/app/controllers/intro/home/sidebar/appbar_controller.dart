import 'package:get/get.dart';

class AppBarController extends GetxController {
  RxBool isSidebarOpen = false.obs;
  RxDouble appBarScale = 1.0.obs;

  void toggleSidebar() {
    isSidebarOpen.value = !isSidebarOpen.value;
    appBarScale.value = isSidebarOpen.value ? 0.8 : 1.0;
  }
}
