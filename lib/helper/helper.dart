import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelper {
  static bool isDarkMode(BuildContext build) {
    return Theme.of(build).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext build ) {
    return MediaQuery.of(build).size;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }
}