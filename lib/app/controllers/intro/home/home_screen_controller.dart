import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }
}
